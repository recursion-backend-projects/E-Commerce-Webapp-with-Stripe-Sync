class CreateDownloadProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :download_products do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    add_index :download_products, [:customer_id, :product_id], unique: true
  end
end
