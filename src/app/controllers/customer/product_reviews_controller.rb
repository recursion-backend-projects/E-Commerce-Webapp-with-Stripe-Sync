class Customer::ProductReviewsController < ApplicationController
  before_action :authenticate_customer_account!
  before_action :set_product, only: [:show, :new, :create]

  def show
    @customer = true
    @product = Product.find(params[:product_id])
    @product_reviews = @product.product_reviews.order(created_at: :desc).includes(customer: :customer_account)
    @average_rating = @product_reviews.average(:rating).to_i
  end

  def new
    @customer = true
    @product = Product.find(params[:product_id])
    @product_review = ProductReview.new(product: @product)
    @existing_review = ProductReview.find_by(product: @product, customer: current_customer_account)
    @product_reviews = @product.product_reviews.order(created_at: :desc).includes(customer: :customer_account)
    @average_rating = @product_reviews.average(:rating).to_i
  end

  def create
    @product_review = ProductReview.new(product_review_params)

    if @product_review.save
      redirect_to product_path(@product), notice: 'レビューが投稿されました。'
    else
      redirect_to product_path(@product), notice: 'レビューは投稿されていません。'
      # render :new
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = '商品が見つかりません'
    redirect_to root_path
  end

  def product_review_params
    params.require(:product_review).permit(:title, :review, :rating, :customer_id, :product_id)
  end
end

