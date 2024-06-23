class Product < ApplicationRecord
  acts_as_taggable_on :tags

  belongs_to :product_category, optional: true
  enum :status, { draft: 0, published: 1, archived: 2 }
  enum :product_type, { digital: 0, physics: 1 }

  with_options presence: true do
    validates :name, length: { maximum: 250 }
  end

  with_options allow_blank: true do
    validates :price, numericality: { only_integer: true, in: 0..99_999_999 }
    validates :stock, numericality: { only_integer: true, in: 0..99_999_999 }
    validates :description, length: { maximum: 250 }
    validates :creator, length: { maximum: 150 }
    validates :stripe_product_id, length: { maximum: 250 }
    validates :stripe_price_id, length: { maximum: 250 }
  end

  # 商品画像バリデーション
  validates :images, attached: false, content_type: ['image/png', 'image/jpeg', 'image/jpg'],
                     size: { less_than: 3.megabytes }

  # ダウンロード用zipバリデーション
  validates :digital_file, attached: false, content_type: ['application/zip'],
                           size: { less_than: 20.megabytes }

  validate :validate_tag

  has_many :wish_products, dependent: :destroy
  has_many :favorite_products, dependent: :destroy
  has_many :customers, through: :wish_products
  has_many :product_reviews, dependent: :destroy
  has_many_attached :images
  has_one_attached :digital_file
  has_one :order_item, dependent: :destroy

  ransacker :average_rating do |_parent|
    Arel.sql('(SELECT AVG(product_reviews.rating) FROM product_reviews WHERE product_reviews.product_id = products.id)')
  end

  # Ransackで検索可能な関連付けを指定するメソッド
  def self.ransackable_associations(_auth_object = nil)
    %w[product_category taggings tags]
  end

  # Ransackで検索可能な属性を指定するメソッド
  def self.ransackable_attributes(_auth_object = nil)
    %w[creator description name price average_rating]
  end

  ##
  # 受け取ったStripe Price Objectが以下のいずれかの条件を満たしていない場合はtrueを返す
  # 条件1: 1回限り (type: one_time)
  # 条件2: 定額 (billing_scheme: per_unit)
  # 条件3: 日本円 (currency: jpy)
  ##
  def self.stripe_price_invalid?(stripe_price)
    stripe_price.billing_scheme != 'per_unit' || stripe_price.type != 'one_time' || stripe_price.currency != 'jpy' || !stripe_price.transform_quantity.nil?
  end

  def remaining_stock
    product_count_in_cart = @current_cart&.dig(id.to_s) || 0
    stock - product_count_in_cart
  end

  def update_stripe_price
    old_price = Stripe::Price.retrieve(stripe_price_id)
    new_price = Stripe::Price.create({
                                       currency: 'jpy',
                                       unit_amount: price,
                                       product: stripe_product_id
                                     })
    Stripe::Product.update(stripe_product_id, {
                             default_price: new_price.id
                           })
    Stripe::Price.update(old_price.id, { active: false })
  end

  private

  def validate_tag
    tag_list.each do |tag_name|
      tag = Tag.new(name: tag_name)
      tag.validate_name
      tag.errors.messages[:name].each { |message| errors.add(:tag_list, message) }
    end
  end
end
