class Customer::SearchProductsController < ApplicationController

  def index
    @customer = true
    @search.sorts = 'average_rating desc' if @search.sorts.empty?
    @keyword = params[:q]["name_or_description_or_creator_or_product_category_name_cont"] || params[:q]["product_category_name_eq"]
    @products = @keyword == "" ? nil : @search.result(distinct: true)
    @average_ratings = {}

    if @products.present?
      @products.each do |product|
        @average_ratings[product.id] = product.product_reviews.average(:rating).to_i
      end
    end
  end
end
