class ChangePriceAndDescriptionInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :products, :price, true
    change_column_default :products, :price, 0
    change_column_null :products, :description, true
  end
end
