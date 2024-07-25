class HomeController < ApplicationController
  def index
    # アピールしたい商品はここで調整する
    @featured_products = Product.where(status: :published).order(updated_at: :desc).limit(3)
    @popular_products = Product.where(status: :published).order('RAND()').limit(3)
  end
end
