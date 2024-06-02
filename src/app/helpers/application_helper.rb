module ApplicationHelper
  def wishlist_button(product, current_customer_account)
    customer = current_customer_account.customer
    # 既にウィッシュリストに商品が存在するかチェック
    already_in_wishlist = customer.wish_products.exists?(product_id: product.id)
    if already_in_wishlist
      content_tag(:div, class: 'my-2 md:mx-6 md:w-1/3') do
        button_tag(type: 'button', class: 'rounded-xl border border-gray-300 bg-gray-200 px-6 py-2 text-gray-500 cursor-not-allowed w-full',
                   disabled: true) do
          '既にウィッシュリストに追加済み'
        end
      end
    else
      form_with(url: customer_account_wish_products_path(current_customer_account), method: :post, class: 'my-2 md:mx-6 md:w-1/3') do |form|
        concat hidden_field_tag(:product_id, product.id)
        concat form.submit('ウィッシュリストに追加する',
                           class: 'rounded-xl border border-gray-300 bg-white px-6 py-2 text-gray-500 hover:bg-gray-100 hover:text-gray-700 w-full')
      end
    end
  end

  def favorite_button(product, current_customer_account)
    customer = current_customer_account.customer
    # 既にお気に入りリストに商品が存在するかチェック
    already_in_favorites = customer.favorite_products.exists?(product_id: product.id)
    if already_in_favorites
      content_tag(:div, class: 'my-2 md:mx-6 md:w-1/3') do
        button_tag(type: 'button', class: 'rounded-xl border border-gray-300 bg-gray-200 px-6 py-2 text-gray-500 cursor-not-allowed w-full',
                   disabled: true) do
          '既にお気に入りリストに追加済み'
        end
      end
    else
      form_with(url: favorite_products_path, method: :post, class: 'my-2 md:mx-6 md:w-1/3') do |form|
        concat hidden_field_tag(:product_id, product.id)
        concat form.submit('お気に入りリストに追加する',
                           class: 'rounded-xl border border-gray-300 bg-white px-6 py-2 text-gray-500 hover:bg-gray-100 hover:text-gray-700 w-full')
      end
    end
  end

  def star_rating(rating)
    rating = 0 if rating.nil?
    full_stars = '★' * rating
    empty_stars = '☆' * (5 - rating)
    full_stars + empty_stars
  end
end
