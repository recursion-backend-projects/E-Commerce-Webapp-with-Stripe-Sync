class AddUniqueIndexToShippingsTrackingNumber < ActiveRecord::Migration[7.1]
  def change
    add_index :shippings, :tracking_number, unique: true
  end
end
