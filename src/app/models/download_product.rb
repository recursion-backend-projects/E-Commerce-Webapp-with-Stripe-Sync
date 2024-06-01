class DownloadProduct < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  after_create :generate_download_url

  def generate_download_url
    self.download_url = Rails.application.routes.url_helpers.rails_blob_path(
      product.digital_file,
      only_path: false,
      disposition: 'attachment'
    )
    save
  end
end
