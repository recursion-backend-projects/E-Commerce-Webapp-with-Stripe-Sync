class Customer::FavoriteProductsController < ApplicationController
  before_action :authenticate_customer_account!

  def index
    @customer = true
    @favorite_products = current_customer_account.customer.favorite_products
  end

  def create
    product = Product.find(params[:product_id])
    favorite_product = current_customer_account.customer.favorite_products.new(product:)

    if favorite_product.save
        redirect_to product_path(product.id)
    else
        redirect_to products_path, alert: 'Failed to add product to favorites.'
    end
  end

  def destroy
    favorite_product = current_customer_account.customer.favorite_products.find(params[:id])
    favorite_product.destroy

    redirect_to favorite_products_path(), notice: 'Product removed from favorites.'
  rescue ActiveRecord::RecordNotFound
    redirect_to favorite_products_path(), alert: 'Favorite product not found.'
  end
end
