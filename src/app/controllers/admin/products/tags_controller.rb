class Admin::Products::TagsController < ApplicationController
  before_action :authenticate_admin_account!

  def index
    @admin = true
    @tags = Product.tags_on(:tags)
  end

  def destroy
    ActsAsTaggableOn::Tag.destroy(params[:id])

    redirect_to admin_products_tags_path, status: :see_other, notice: 'タグを削除しました'
  end

  def whitelist
    tags = Product.tag_counts_on(:tags).where('name LIKE ?', "#{Product.sanitize_sql_like(params[:name])}%")
    whitelist = tags.map(&:name)

    render json: whitelist
  end
end
