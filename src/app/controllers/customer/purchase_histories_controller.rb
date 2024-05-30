class Customer::PurchaseHistoriesController < ApplicationController
  before_action :authenticate_customer_account!

  def show
    @customer = true
    # TODO: 購入した商品のみ取得するように変更する
    @products = Product.all
    @product_reviews = @products.each_with_object({}) do |product, hash|
      hash[product.id] = ProductReview.find_by(product:, customer: current_customer_account)
    end
  end
end
