class DownloadProduct < ApplicationRecord
    belongs_to :customer
    belongs_to :product
    after_create :generate_download_url

    validates :customer_id, uniqueness: { scope: :product_id, message: 'この商品はすでにダウンロードリストに追加されています。' }

    def generate_download_url
        self.download_url = Rails.application.routes.url_helpers.rails_blob_path(
          self.product.digital_file,
          only_path: false,
          disposition: "attachment",
        )
        save
    end
end