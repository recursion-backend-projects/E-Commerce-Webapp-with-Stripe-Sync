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
  { name: '夕焼けの絵画', price: 5000, stock: 10, description: '美しい夕焼けの絵画。', status: 'draft', creator: '高橋優', product_category_name: '絵画', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnu0', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ0' },
  { name: '朝の光', price: 5000, stock: 5, description: '美しい朝の光が差し込む風景を描いた作品。柔らかな色使いが特徴です。', status: 'draft', creator: '佐藤一郎', product_category_name: '絵画', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnu1', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ1' },
  { name: '夕暮れの街', price: 7500, stock: 3, description: '夕暮れ時の街の風景をリアルに描いた作品。温かみのある色彩が魅力です。', status: 'draft', creator: '山田花子', product_category_name: '絵画', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnu2', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ2' },
  { name: '静かな湖畔', price: 6000, stock: 4, description: '静かな湖畔の風景を描いた作品。穏やかな水面と自然の美しさが表現されています。', status: 'draft', creator: '中村太郎', product_category_name: '絵画', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnu3', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ3' },
  { name: '森の中', price: 4500, stock: 2, description: '森の中の風景を描いた作品。木々の緑と光の陰影が美しいです。', status: 'draft', creator: '小林美咲', product_category_name: '絵画', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnu4', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ4' },
  { name: '春の花畑', price: 5500, stock: 0, description: '春の花畑を描いた作品。色とりどりの花が咲き誇る様子が鮮やかに描かれています。', status: 'draft', creator: '田中次郎', product_category_name: '絵画', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnu5', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ5' },
  { name: '夏の海', price: 8000, stock: 1, description: '夏の海の風景を描いた作品。青い海と空の広がりが印象的です。', status: 'draft', creator: '松本真理', product_category_name: '絵画', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnu6', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ6' },
  { name: '秋の山', price: 7000, stock: 2, description: '秋の山の風景を描いた作品。紅葉の美しさが際立っています。', status: 'draft', creator: '藤井剛', product_category_name: '絵画', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnu7', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ7' },
  { name: '冬の雪景色', price: 6500, stock: 0, description: '冬の雪景色を描いた作品。白銀の世界が広がる美しい風景です。', status: 'draft', creator: '森山桜', product_category_name: '絵画', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnu8', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ8' },
  { name: '街の夜景', price: 9000, stock: 2, description: '夜の街の風景を描いた作品。夜景の光がきらめく様子がリアルに描かれています。', status: 'draft', creator: '石田昇', product_category_name: '絵画', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnu9', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTJ9' },
  { name: '大理石の彫刻', price: 15000, stock: 5, description: '詳細な大理石の彫刻。', status: 'draft', creator: '斎藤一郎', product_category_name: '彫刻', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnv0', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK0' },
  { name: '木彫りの熊', price: 10000, stock: 3, description: '伝統的な木彫りの熊。', status: 'draft', creator: '田中次郎', product_category_name: '彫刻', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnv1', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK1' },
  { name: '青銅の像', price: 20000, stock: 2, description: '青銅で作られた美しい像。', status: 'draft', creator: '山本花子', product_category_name: '彫刻', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnv2', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK2' },
  { name: '抽象彫刻', price: 12000, stock: 4, description: '現代的な抽象彫刻。', status: 'draft', creator: '佐藤一郎', product_category_name: '彫刻', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnv3', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK3' },
  { name: '石の彫刻', price: 8000, stock: 6, description: '石で作られた手作りの彫刻。', status: 'draft', creator: '小林美咲', product_category_name: '彫刻', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnv4', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK4' },
  { name: '陶器の像', price: 9000, stock: 0, description: '陶器で作られた伝統的な像。', status: 'draft', creator: '中村太郎', product_category_name: '彫刻', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnv5', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK5' },
  { name: '鉄の彫刻', price: 18000, stock: 2, description: '鉄で作られた重厚な彫刻。', status: 'draft', creator: '高橋優', product_category_name: '彫刻', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnv6', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK6' },
  { name: 'ガラスの彫刻', price: 15000, stock: 3, description: '透明感のあるガラスの彫刻。', status: 'draft', creator: '石田昇', product_category_name: '彫刻', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnv7', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK7' },
  { name: 'プラスチックの像', price: 7000, stock: 0, description: 'カラフルなプラスチックで作られた像。', status: 'draft', creator: '森山桜', product_category_name: '彫刻', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnv8', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK8' },
  { name: '紙の彫刻', price: 5000, stock: 7, description: '紙で作られた繊細な彫刻。', status: 'draft', creator: '藤井剛', product_category_name: '彫刻', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnv9', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTK9' },
  { name: '白黒写真', price: 3000, stock: 20, description: 'クラシックな白黒写真。', status: 'draft', creator: '藤井剛', product_category_name: '写真', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnw0', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL0' },
  { name: '夕焼けの海', price: 3000, stock: 15, description: '美しい夕焼けの海の写真。', status: 'draft', creator: '鈴木一郎', product_category_name: '写真', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnw1', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL1' },
  { name: '朝霧の森', price: 3500, stock: 10, description: '朝霧が立ち込める森の風景写真。', status: 'draft', creator: '田中次郎', product_category_name: '写真', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnw2', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL2' },
  { name: '雪山の頂', price: 5000, stock: 0, description: '雪山の頂を捉えた写真。', status: 'draft', creator: '山田花子', product_category_name: '写真', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnw3', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL3' },
  { name: '都会の夜景', price: 4000, stock: 8, description: '都会の夜景を撮影した写真。', status: 'draft', creator: '佐藤三郎', product_category_name: '写真', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnw4', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL4' },
  { name: '春の花', price: 4500, stock: 12, description: '春の花が咲き乱れる花の写真。', status: 'draft', creator: '小林美咲', product_category_name: '写真', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnw5', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL5' },
  { name: '秋の紅葉', price: 3800, stock: 6, description: '紅葉の美しい秋の風景写真。', status: 'draft', creator: '中村太郎', product_category_name: '写真', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnw6', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL6' },
  { name: '冬の夜空', price: 3200, stock: 0, description: '冬の夜空に輝く星々の写真。', status: 'draft', creator: '高橋優', product_category_name: '写真', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnw7', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL7' },
  { name: '海岸の朝', price: 3700, stock: 11, description: '朝の海岸の風景を捉えた写真。', status: 'draft', creator: '石田昇', product_category_name: '写真', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnw8', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL8' },
  { name: '田園風景', price: 3400, stock: 7, description: '田園風景の広がる美しい写真。', status: 'draft', creator: '森山桜', product_category_name: '写真', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnw9', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTL9' },
  { name: 'デジタルイラスト', price: 4000, stock: 15, description: '鮮やかなデジタルイラスト。', status: 'draft', creator: '宮田薫', product_category_name: 'イラスト', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnx', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM0' },
  { name: '夢見る少年', price: 4500, stock: 10, description: '夢の中で冒険する少年を描いたイラスト。', status: 'draft', creator: '青木涼', product_category_name: 'イラスト', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnx1', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM1' },
  { name: '魔法の森', price: 5000, stock: 8, description: '魔法の森を舞台にした幻想的なイラスト。', status: 'draft', creator: '高田春', product_category_name: 'イラスト', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnx2', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM2' },
  { name: '海底の王国', price: 6000, stock: 5, description: '海底の王国を描いた美しいイラスト。', status: 'draft', creator: '山口夏', product_category_name: 'イラスト', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnx3', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM3' },
  { name: '銀河の旅', price: 5500, stock: 7, description: '銀河を旅する冒険者たちを描いたイラスト。', status: 'draft', creator: '中田秋', product_category_name: 'イラスト', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnx4', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM4' },
  { name: 'ファンタジーキャッスル', price: 7000, stock: 0, description: 'ファンタジー世界のキャッスルを描いた壮大なイラスト。', status: 'draft', creator: '佐々木冬', product_category_name: 'イラスト', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnx5', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM5' },
  { name: '妖精の森', price: 4800, stock: 9, description: '妖精が住む森を描いた可愛らしいイラスト。', status: 'draft', creator: '西田光', product_category_name: 'イラスト', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnx6', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM6' },
  { name: 'ドラゴンの巣', price: 6500, stock: 6, description: 'ドラゴンの巣を舞台にした迫力あるイラスト。', status: 'draft', creator: '東野翼', product_category_name: 'イラスト', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnx7', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM7' },
  { name: '未来都市', price: 5200, stock: 11, description: '未来の都市を描いた近未来的なイラスト。', status: 'draft', creator: '北村亮', product_category_name: 'イラスト', product_type: 1, stripe_product_id: 'prod_QASQuJHkOEtVnx8', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM8' },
  { name: '異世界の冒険者', price: 5800, stock: 0, description: '異世界で冒険する勇者たちを描いたイラスト。', status: 'draft', creator: '藤原優', product_category_name: 'イラスト', product_type: 0, stripe_product_id: 'prod_QASQuJHkOEtVnx9', stripe_price_id: 'price_1PK7Vj2KrybDMqMJUZMhUUTM9' }
]

if Rails.env.development?
  products.each do |product_data|
    product_category = ProductCategory.find_or_create_by!(name: product_data.delete(:product_category_name))
    Product.find_or_create_by!(name: product_data[:name]) do |product|
      product.price = product_data[:price]
      product.stock = product_data[:stock]
      product.description = product_data[:description]
      product.status = product_data[:status]
      product.creator = product_data[:creator]
      product.product_type = product_data[:product_type]
      product.product_category = product_category
      product.stripe_product_id = product_data[:stripe_product_id]
      product.stripe_price_id = product_data[:stripe_price_id]
    end
  end
end
