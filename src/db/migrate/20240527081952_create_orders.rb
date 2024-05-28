class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :order_number, index: { unique: true}
      t.integer :total
      t.datetime :order_date
      t.string :guest_email
      t.string :receipt_url
      t.references :customer, null: true, foreign_key: true

      t.timestamps
    end
  end
end
