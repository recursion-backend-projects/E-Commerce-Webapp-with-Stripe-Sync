class CreateWishProductTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :wish_product_tokens do |t|
      t.string :token, index: { unique: true }
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
