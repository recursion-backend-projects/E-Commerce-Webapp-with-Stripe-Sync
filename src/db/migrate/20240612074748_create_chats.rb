class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.integer :status, default: 0
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
