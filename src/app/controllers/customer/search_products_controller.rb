class Customer::SearchProductsController < ApplicationController
  # 許可するカラム名を指定
  VALID_COLUMNS = {"name" => "商品名", "description" => "商品説明", "creator" => "作者", "category" => "カテゴリー", "created_at" => "リリース日"}

  def index
    @customer = true
    @type = params[:type]
    @keyword = params[:keyword]
    @products = nil
    @column_name = nil
    @average_ratings = {}

    if @type.present? && @keyword.present? && VALID_COLUMNS.keys.include?(@type)
      if @type == "category"
        @products = Product.joins(:product_category).where(product_category: { name: "#{@keyword}" }) 
      else
        @products = Product.where("#{@type} LIKE ?", "%#{@keyword}%")
      end
      @column_name = VALID_COLUMNS[@type]
    end

    if @products.present?
      @products.each do |product|
        @average_ratings[product.id] = product.product_reviews.average(:rating).to_i
      end
    end
  end
end
