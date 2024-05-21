# カスタマーのルーティング
scope module: :customer do
  resources :products, only: %i[show]
  get 'cart', to: 'carts#show'
  post 'add', to: 'carts#add', as: 'add_to_cart'
  patch 'update', to: 'carts#update', as: 'update_cart'

  resources :customer_accounts, only: [] do
    resources :wish_products, only: %i[index create destroy]
  end
end
