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
      product_category = ProductCategory.find(@product.product_category_id)
      Stripe::Product.update(@product.stripe_product_id, name: @product.name,
                                                         description: @product.description,
                                                         metadata: { product_category: product_category.name })

      # Stripe APIではPriceのunit_amountを変更できないので、新しいPriceを作成して、デフォルトの価格を変更して、古い価格は無効にする
      # https://docs.stripe.com/products-prices/manage-prices#edit-price
      old_price = Stripe::Price.retrieve(@product.stripe_price_id)

      # 価格が編集された場合のみ、Priceを更新する
      if @product.price != old_price.unit_amount
        new_price = Stripe::Price.create(currency: 'jpy', unit_amount: @product.price,
                                         product: @product.stripe_product_id)
        Stripe::Product.update(@product.stripe_product_id, default_price: new_price.id)
        Stripe::Price.update(old_price.id, active: false)
      end

      # 更新前のデータが表示される場合があるのでキャッシュを無効化する
      expires_now

      redirect_to edit_admin_product_path @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    # 価格を持っている商品はapiで削除できないので、activeをfalseにする
    Stripe::Product.update(@product.stripe_product_id, active: false)
    @product.destroy

    redirect_to admin_products_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :stock, :description, :status, :creator, :product_category_id, images: [])
  end
end
