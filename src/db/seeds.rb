# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'dotenv-rails'

#### Product Categories ####
%w[絵画 彫刻 写真 イラスト].each do |product_category|
  ProductCategory.find_or_create_by!(name: product_category)
end

#### Admin Accounts ####
admin_email = ENV['ADMIN_EMAIL']
admin_password = ENV['ADMIN_PASSWORD']

AdminAccount.find_or_create_by(email: admin_email) do |admin|
  admin.password = admin_password
  admin.password_confirmation = admin_password
  admin.user_name = 'admin'
end

#### Products ####
products = [
  { name: '夕焼けの絵画', price: 5000, stock: 10, description: '美しい夕焼けの絵画。', status: 'draft', product_category_name: '絵画', stripe_product_id: 'prod_QASQuJHkOEtVnu', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ' },
  { name: '大理石の彫刻', price: 15000, stock: 5, description: '詳細な大理石の彫刻。', status: 'draft', product_category_name: '彫刻', stripe_product_id: 'prod_QASQuJHkOEtVnv', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK' },
  { name: '白黒写真', price: 3000, stock: 20, description: 'クラシックな白黒写真。', status: 'draft', product_category_name: '写真', stripe_product_id: 'prod_QASQuJHkOEtVnw', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL' },
  { name: 'デジタルイラスト', price: 4000, stock: 15, description: '鮮やかなデジタルイラスト。', status: 'draft', product_category_name: 'イラスト', stripe_product_id: 'prod_QASQuJHkOEtVnx', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM' }
]

products.each do |product_data|
  product_category = ProductCategory.find_or_create_by!(name: product_data.delete(:product_category_name))
  Product.find_or_create_by!(name: product_data[:name]) do |product|
    product.price = product_data[:price]
    product.stock = product_data[:stock]
    product.description = product_data[:description]
    product.status = product_data[:status]
    product.product_category = product_category
    product.stripe_product_id = product_data[:stripe_product_id]
    product.stripe_price_id = product_data[:stripe_price_id]
  end
end

