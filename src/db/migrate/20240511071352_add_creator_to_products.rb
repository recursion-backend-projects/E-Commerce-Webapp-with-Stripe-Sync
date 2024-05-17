class AddCreatorToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :creator, :string
  end
end
