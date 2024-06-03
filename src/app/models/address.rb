class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
