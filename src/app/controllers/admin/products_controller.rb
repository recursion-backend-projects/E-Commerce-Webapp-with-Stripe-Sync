class Admin::ProductsController < ApplicationController
  def index
    @admin = true
    @products = Product.all
  end

  def edit
    @admin = true
    @product = Product.find(params[:id])
    @categories = ProductCategory.all
  end

  def update
    @admin = true
    @product = Product.find(params[:id])

    if @product.update(product_params)
      Stripe::Product.update(@product.stripe_prodouct_id, name: @product.name, description: @product.description)

      # Stripe APIではPriceのunit_amountを変更できないので、新しいPriceを作成して、デフォルトの価格を変更して、古い価格は無効にする
      # https://docs.stripe.com/products-prices/manage-prices#edit-price
      old_price = Stripe::Price.retrieve(@product.string_price_id)
      new_price = Stripe::Price.create(currencty: 'jpy', unit_amount: @product.price,
                                       product: @product.stripe_prodouct_id)
      Stripe::Product.update(@product.stripe_prodouct_id, default_price: new_price.id)
      Stripe::Price.update(old_price.id, active: false)
      redirect_to edit_admin_product_path @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params)
    Stripe::Product.delete(@product.stripe_prodouct_id)
    @product.destroy

    redirect_to admin_products_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :stock, :description, :status, :creator, :product_category_id)
  end
end
