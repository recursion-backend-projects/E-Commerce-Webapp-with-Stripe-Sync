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

  namespace :admin do
    resources :products, only: %i[index edit destroy update]
  end

  scope module: :customer do
    resources :products, only: %i[show]
    resource :cart, only: %i[show create update destroy]
    resources :checkouts, only: [:create]
    get 'checkout/success', to: 'checkouts#success'
  end

  namespace :webhooks do
    resource :stripe, only: [:create]
  end
end
