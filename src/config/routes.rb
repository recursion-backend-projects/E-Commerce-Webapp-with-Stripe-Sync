Rails.application.routes.draw do
  devise_for :customer_accounts
  devise_for :admin_accounts, controllers: {
    sessions: 'admin_accounts/sessions',
    registrations: 'admin_accounts/registrations',
    confirmations: 'admin_accounts/confirmations',
    passwords: 'admin_accounts/passwords'
  }

  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'sample', to: 'samples#index'

  # Defines the root path route ("/")
  # root "posts#index"

  post 'stripe/webhook', to: 'stripe_webhooks#handler'
end
