class Customer::ProductReviewsController < ApplicationController
  before_action :authenticate_customer_account!, only: %i[new create edit update destroy]
  before_action :set_customer, only: %i[show new edit]
  before_action :set_product
  before_action :set_product_review, only: %i[edit update]

  def show
    @product_reviews = @product.product_reviews.order(created_at: :desc).includes(customer: :customer_account)
    @average_rating = @product_reviews.average(:rating).to_i
  end

  def new
    @existing_review = ProductReview.find_by(product: @product, customer: current_customer_account)
    @product_reviews = @product.product_reviews.includes(customer: :customer_account)
    @average_rating = @product_reviews.average(:rating).to_i
    @errors = flash[:errors]

    if @existing_review
      redirect_to edit_product_product_reviews_path(@product), alert: 'すでにレビューを投稿済みです。'
    else
      @product_review = ProductReview.new(product: @product)
    end
  end

  def edit
    @product_reviews = @product.product_reviews
    @average_rating = @product_reviews.average(:rating).to_i
    @errors = flash[:errors]
  end

  def create
    @existing_review = ProductReview.find_by(product: @product, customer: current_customer_account)
    @product_review = ProductReview.new(product_review_params)

    if @existing_review
      redirect_to edit_product_product_reviews_path(@product), alert: 'すでにレビューを投稿済みです。'
      return
    end

    if @product_review.save
      redirect_to product_product_reviews_path(@product), notice: 'レビューが投稿されました。'
    else
      flash[:errors] = @product_review.errors.full_messages
      redirect_to new_product_product_reviews_path(@product)
    end
  end

  def update
    if @product_review.update(product_review_params)
      redirect_to product_product_reviews_path(@product), notice: 'レビューが更新されました。'
    else
      flash[:errors] = @product_review.errors.full_messages
      redirect_to edit_product_product_reviews_path(@product)
    end
  end

  def destroy
    @product_review = ProductReview.find(params[:productReview_id])
    @product_review.destroy
    redirect_to orders_path, notice: 'レビューが削除されました。'
  end

  private

  def set_customer
    @customer = true
  end

  def set_product
    @product = Product.find_by(id: params[:product_id], status: 'published')
    if @product.nil?
      flash[:alert] = '商品が見つかりません'
      redirect_to root_path
    end
  end

  def set_product_review
    @product_review = ProductReview.find_by(product: @product, customer: current_customer_account)
    redirect_to root_path, alert: 'レビューが見つかりません' if @product_review.nil?
  end

  def product_review_params
    params.require(:product_review).permit(:title, :review, :rating, :customer_id, :product_id)
  end
end
