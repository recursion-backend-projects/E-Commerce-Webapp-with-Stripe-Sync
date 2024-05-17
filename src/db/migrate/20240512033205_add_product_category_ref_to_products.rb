class AddProductCategoryRefToProducts < ActiveRecord::Migration[7.1]
  def change
    add_belongs_to :products, :product_category, foreign_key: true
  end
end
