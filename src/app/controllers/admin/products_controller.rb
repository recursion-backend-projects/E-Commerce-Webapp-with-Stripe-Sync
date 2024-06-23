class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin_account!

  def index
    @admin = true
    @products = Product.all.page(params[:page])
  end

  def new
    @admin = true
    @product = Product.new
    @categories = ProductCategory.all
  end

  def edit
    @admin = true
    @product = Product.find(params[:id])
    @categories = ProductCategory.all
  end

  def create
    @admin = true
    @categories = ProductCategory.all
    @product = Product.new(product_params)

    # stripe オブジェクト作成時にエラーにならないようにここでバリデーション
    if @product.valid?
      stripe_product = Stripe::Product.create({ name: @product.name })
      stripe_price = Stripe::Price.create({ currency: 'jpy', unit_amount: @product.price, product: stripe_product.id })

      if stripe_product && stripe_price
        @product.stripe_product_id = stripe_product.id
        @product.stripe_price_id = stripe_price.id
        @product.save
        redirect_to edit_admin_product_path(@product), notice: '商品が追加されました。'
      end
    else
      flash.now[:alert] = '商品の追加に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @admin = true
    @product = Product.find(params[:id])

    begin
      if @product.update(product_params)
        # 名前が変更された場合、Stirpe側の名前も更新する
        Stripe::Product.update(@product.stripe_product_id, { name: @product.name }) if @product.saved_change_to_name?
        # 価格が変更された場合、Stirpe側の価格も更新する
        @product.update_stripe_price if @product.saved_change_to_price?

        redirect_to edit_admin_product_path(@product), notice: '商品が更新されました。'
      else
        @categories = ProductCategory.all
        flash.now[:alert] = '更新に失敗しました'
        render :edit, status: :unprocessable_entity
      end
    rescue ActiveStorage::IntegrityError, ActiveRecord::RecordInvalid, ArgumentError => e
      handle_update_error(e)
    rescue Stripe::InvalidRequestError => e
      handle_stripe_error(e)
    end
  end

  def destroy
    @product = Product.find(params[:id])
    Stripe::Product.update(@product.stripe_product_id, active: false)
    @product.destroy

    redirect_to admin_products_path, status: :see_other
  end

  private

  def product_params
    permitted_params = %i[name price stock description status creator product_category_id product_type tag_list]
    permitted_params << { images: [] } if params[:product][:images].compact_blank.present? || params[:product][:remove_image] == '1'
    permitted_params << :digital_file if params[:product][:digital_file].present? || params[:product][:remove_digital_file] == '1'
    params[:product][:digital_file] = nil if params[:product][:remove_digital_file] == '1'
    params.require(:product).permit(permitted_params)
  end

  def handle_update_error(error)
    Rails.logger.error "Update Error: #{error.message}"
    @categories = ProductCategory.all
    render :edit, status: :unprocessable_entity
  end

  def handle_stripe_error(error)
    Rails.logger.error "Stripe Error: #{error.message}"
    @categories = ProductCategory.all
    render :edit, status: :unprocessable_entity
  end
end
