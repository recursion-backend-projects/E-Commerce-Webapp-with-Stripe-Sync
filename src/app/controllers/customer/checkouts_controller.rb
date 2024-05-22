class Customer::CheckoutsController < ApplicationController
  def create
    line_items = generate_line_items
    session = Stripe::Checkout::Session.create({
                                                 line_items:,
                                                 mode: 'payment',
                                                 #  TODO: 支払いに成功・失敗した時に表示するページを準備する
                                                 cancel_url: 'http://localhost:3000/cart',
                                                 success_url: 'http://localhost:3000/cart'
                                               })
    redirect_to session.url, allow_other_host: true
  end

  private

  def generate_line_items
    line_items = []
    cart = session[:cart]
    cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id.to_i)

      next unless product

      line_item = {
        price: product.stripe_price_id,
        quantity:
      }

      line_items << line_item
    end

    line_items
  end
end
