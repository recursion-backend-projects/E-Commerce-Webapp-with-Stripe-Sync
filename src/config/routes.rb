Rails.application.routes.draw do
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

  post 'stripe/webhook', to: 'stripe_webhooks#handler'

  namespace :admin do
    resources :products, only: %i[index edit destroy update]
  end

  scope module: :customer do
    resources :products, only: %i[show]
    get 'cart', to: 'carts:show', as: 'cart'
    post 'add_to_cart', to: 'carts#add_to_cart', as: 'add_to_cart'
  end
end
