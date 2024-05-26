class CreateProductReviews < ActiveRecord::Migration[7.1]

  def change
    create_table :product_reviews do |t|
      t.integer :rating, null: false
      t.string :title, null: false
      t.string :review, null: false
      t.references :customer, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    add_index :product_reviews, [:customer_id, :product_id], unique: true
  end
end
