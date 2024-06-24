class Customer::SearchProductsController < ApplicationController
  def index
    @customer = true
    # デフォルトの並び替えを高評価順で設定する
    @search.sorts = 'average_rating desc' if @search.sorts.empty?
    # 不要な全角空白があれば、削除する
    if @search.name_or_description_or_creator_or_product_category_name_or_tags_name_cont.present?
      @search.name_or_description_or_creator_or_product_category_name_or_tags_name_cont =
        @search.name_or_description_or_creator_or_product_category_name_or_tags_name_cont.gsub(/　/, ' ').strip
    end
    @keyword = "検索結果 : " + @search.name_or_description_or_creator_or_product_category_name_or_tags_name_cont if 
                @search.name_or_description_or_creator_or_product_category_name_or_tags_name_cont.present? 
    @products = @search.result(distinct: true).where(status: 'published').page(params[:page])
    @average_ratings = get_average_ratings(@products)
  end

  private

  def get_average_ratings(products)
    return {} if products.blank?

    average_ratings = {}

    products.each do |product|
      average_ratings[product.id] = product.product_reviews.average(:rating).to_i
    end

    average_ratings
  end
end
