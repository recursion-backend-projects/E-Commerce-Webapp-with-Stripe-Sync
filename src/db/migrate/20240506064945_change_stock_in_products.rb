class ChangeStockInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :products, :stock, true
  end
end
