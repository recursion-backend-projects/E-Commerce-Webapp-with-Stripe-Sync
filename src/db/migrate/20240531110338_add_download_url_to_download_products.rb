class AddDownloadUrlToDownloadProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :download_products, :download_url, :string
  end
end
