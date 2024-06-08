class CustomerAccount < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable

  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  }, on: :create

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'の形式が不正です' }

  with_options allow_blank: true do
    validates :user_name, length: { in: 3..20 }, format: { with: /\A[a-zA-Z0-9_]+\z/, message: 'は英数字とアンダースコアのみ使用できます' }
    validates :shipping_name, length: { maximum: 50 }
    validates :phone_number, format: { with: /\A(090|080|070)-\d{4}-\d{4}\z/, message: 'の形式が不正です' }
  end

  belongs_to :customer

  # Eメール認証後に実行するdeviseの関数をオーバーライド
  def after_confirmation
    create_stripe_customer
  end

  private

  def create_stripe_customer
    stripe_customer = Stripe::Customer.create({
                                                name: user_name,
                                                email:
                                              })
    customer = Customer.find_by(id: customer_id)
    customer.update(stripe_customer_id: stripe_customer.id)
  end
end
