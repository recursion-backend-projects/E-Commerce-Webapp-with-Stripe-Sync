class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :stock, null: false, default: 0
      t.text :description, null: false

      t.timestamps
    end
  end
end
