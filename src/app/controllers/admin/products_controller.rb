class Admin::ProductsController < ApplicationController
  def index
    @admin = true
    @products = Product.all
  end

  def edit
    @admin = true
    @product = Product.find(params[:id])
  end

  def update
    @admin = true
    @product = Product.find(params[:id])

    if @product.update(product_params[:id])
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to admin_products_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description)
  end
end
