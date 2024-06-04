class CreateShippings < ActiveRecord::Migration[7.1]
  def change
    create_table :shippings do |t|
      t.integer :carrier
      t.string :tracking_number
      t.integer :status
      t.datetime :shipping_at
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
