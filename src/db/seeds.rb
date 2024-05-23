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
  { name: 'Sunset Painting', price: 5000, stock: 10, description: 'A beautiful sunset painting.', status: 1, product_category_name: '絵画' },
  { name: 'Marble Sculpture', price: 15000, stock: 5, description: 'A detailed marble sculpture.', status: 1, product_category_name: '彫刻' },
  { name: 'Black and White Photo', price: 3000, stock: 20, description: 'A classic black and white photograph.', status: 1, product_category_name: '写真' },
  { name: 'Digital Illustration', price: 4000, stock: 15, description: 'A vibrant digital illustration.', status: 1, product_category_name: 'イラスト' }
]

products.each do |product_data|
  category = ProductCategory.find_by(name: product_data[:product_category_name])
  Product.find_or_create_by!(name: product_data[:name]) do |product|
    product.price = product_data[:price]
    product.stock = product_data[:stock]
    product.description = product_data[:description]
    product.status = product_data[:status]
    product.product_category = category
  end
end
