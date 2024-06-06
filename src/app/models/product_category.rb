class ProductCategory < ApplicationRecord
  validates :name, presence: true

  # Ransackで検索可能な属性を指定するメソッド
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
