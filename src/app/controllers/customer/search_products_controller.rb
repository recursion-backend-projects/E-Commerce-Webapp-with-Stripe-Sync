class Customer::SearchProductsController < ApplicationController
  def index
    @customer = true
    apply_filters

    @keyword = "検索結果 : #{@search.name_or_description_or_creator_or_product_category_name_or_tags_name_cont}" if
                @search.name_or_description_or_creator_or_product_category_name_or_tags_name_cont.present?
    @products = @search.result(distinct: true).where(status: 'published').page(params[:page])
    @average_ratings = get_average_ratings(@products)

    @tag_names = Tag.joins(:taggings).where(taggings: { taggable_id: Product.where(status: 'published').map(&:id),
                                                        taggable_type: 'Product' }).distinct.map(&:name)
    @creators = Product.where(status: 'published').map(&:creator)
    @categories = ProductCategory.all.map(&:name)
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

  def apply_filters
    set_default_sorting
    sanitize_search_keywords
    convert_date_filters
  end

  def set_default_sorting
    # デフォルトの並び替えを高評価順で設定する
    @search.sorts = 'average_rating desc' if @search.sorts.empty?
  end

  def sanitize_search_keywords
    # 不要な全角空白があれば、削除する
    return if @search.name_or_description_or_creator_or_product_category_name_or_tags_name_cont.nil?

    @search.name_or_description_or_creator_or_product_category_name_or_tags_name_cont =
      @search.name_or_description_or_creator_or_product_category_name_or_tags_name_cont.gsub(/　/, ' ').strip
  end

  def convert_date_filters
    # 日付のみ扱うように変換
    @search.released_at_gteq = @search.released_at_gteq.to_date if @search.released_at_gteq.present?
  end
end
