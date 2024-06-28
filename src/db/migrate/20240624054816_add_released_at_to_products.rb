class AddReleasedAtToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :released_at, :datetime
  end
end
