class CreateWishProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :wish_products do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    add_index :wish_products, [:customer_id, :product_id], unique: true
  end
end
