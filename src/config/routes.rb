Rails.application.routes.draw do
  root 'home#index'

  # アカウント認証(カスタマー)
  devise_for :customer_accounts, controllers: {
    sessions: 'customer_accounts/sessions',
    registrations: 'customer_accounts/registrations',
    confirmations: 'customer_accounts/confirmations',
    passwords: 'customer_accounts/passwords'
  }

  # アカウント認証(管理者)
  devise_for :admin_accounts, controllers: {
    sessions: 'admin_accounts/sessions',
    registrations: 'admin_accounts/registrations',
    confirmations: 'admin_accounts/confirmations',
    passwords: 'admin_accounts/passwords'
  }

  get 'up' => 'rails/health#show', as: :rails_health_check
  get 'sample', to: 'samples#index'
  get 'customer-test', to: 'customer_tests#index'

  # Defines the root path route ("/")
  # root "posts#index"

  # 管理者のルーティング
  namespace :admin do
    namespace :products do
      resources :tags, only: %i[index destroy]
      get 'tags/whitelist', to: 'tags#whitelist'
    end
    resources :products, only: %i[index edit destroy update]
    resources :shippings, only: %i[index edit update]
  end
  # カスタマーのルーティング
  scope module: :customer do
    resources :products, only: %i[show]
    resource :cart, only: %i[show create update destroy]
    resources :favorite_products, only: %i[index create destroy]
    resources :download_products, only: %i[index]
    resources :customer_accounts, only: [] do
      resources :wish_products, only: %i[index create destroy]
    end
    resources :products, only: [] do
      resource :product_reviews, only: %i[show new create edit update destroy]
    end
    resource :checkout, only: %i[create]
    get 'checkout/success', to: 'checkouts#success'

    resources :orders, only: [:index]
    resource :account, only: %i[show edit update]
  end

  namespace :webhooks do
    resource :stripe, only: [:create]
  end
end
