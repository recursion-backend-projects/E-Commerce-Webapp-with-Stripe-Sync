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
  
    begin
      if @product.update(product_params)
        product_category = ProductCategory.find(@product.product_category_id)
  
        Stripe::Product.update(@product.stripe_product_id, {
          name: @product.name,
          description: @product.description,
          metadata: { product_category: product_category.name }
        })
  
        old_price = Stripe::Price.retrieve(@product.stripe_price_id)
        if @product.price != old_price.unit_amount
          new_price = Stripe::Price.create({
            currency: 'jpy',
            unit_amount: @product.price,
            product: @product.stripe_product_id
          })
          Stripe::Product.update(@product.stripe_product_id, {
            default_price: new_price.id
          })
          Stripe::Price.update(old_price.id, { active: false })
        end
  
        expires_now
        redirect_to edit_admin_product_path(@product), notice: '商品が更新されました。'
      else
        @categories = ProductCategory.all
        render :edit, status: :unprocessable_entity
      end
    rescue ActiveStorage::IntegrityError, ActiveRecord::RecordInvalid, ArgumentError => e
      @product.errors.add(:base, "保存エラー: #{e.message}")
      @categories = ProductCategory.all
      render :edit, status: :unprocessable_entity
    rescue Stripe::InvalidRequestError => e
      @product.errors.add(:base, "Stripeの更新エラー: #{e.message}")
      @categories = ProductCategory.all
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
    if params[:product][:images].reject(&:blank?).present?
      params.require(:product).permit(:name, :price, :stock, :description, :status, :creator, :product_category_id, images: [])
    else
      params.require(:product).permit(:name, :price, :stock, :description, :status, :creator, :product_category_id)
    end
  end
end
