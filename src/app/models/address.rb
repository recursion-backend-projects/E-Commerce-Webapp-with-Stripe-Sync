class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

  with_options allow_blank: true do
    validates :zip_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'の形式が不正です（例:123-4567）' }
    validates :prefecture_id, numericality: { only_integer: true, in: 1..47 }
    validates :street_address, length: { maximum: 200 }
    validates :street_address_2, length: { maximum: 200 }
  end
end
