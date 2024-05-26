class AddUniqueIndexToFavoriteProducts < ActiveRecord::Migration[7.1]
  def change
    add_index :favorite_products, [:customer_id, :product_id], unique: true
  end
end
