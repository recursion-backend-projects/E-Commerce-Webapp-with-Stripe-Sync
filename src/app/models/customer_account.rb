class CustomerAccount < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable

  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  }, on: :create

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
