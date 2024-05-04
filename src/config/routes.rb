Rails.application.routes.draw do
  devise_for :admin_accounts, controllers: {
     sessions: 'admin_accounts/sessions',
     registrations: 'admin_accounts/registrations'
  }

  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'sample', to: 'samples#index'

end
