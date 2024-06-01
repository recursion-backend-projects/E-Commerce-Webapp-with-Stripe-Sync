class Customer::SearchProductsController < ApplicationController
  # 許可するカラム名を指定
  VALID_COLUMNS = ["name", "description", "category", "creator"]

  def index
    @customer = true

    if params[:type].present? && params[:keyword].present? && VALID_COLUMNS.include?(params[:type])
      if params[:type] == "category"
        @products = Product.joins(:product_category).where(product_category: { name: "#{params[:keyword]}" }) 
      else
        @products = Product.where("#{params[:type]} LIKE ?", "%#{params[:keyword]}%")
      end
    else
      @products = Product.all
    end
  end

  # def set_product
  #   @product = Product.find(params[:product_id])
  # rescue ActiveRecord::RecordNotFound
  #   redirect_to root_path, alert: '商品が見つかりません'
  # end
end
