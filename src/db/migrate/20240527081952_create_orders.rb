class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.integer :total
      t.datetime :order_date
      t.string :guest_email
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
