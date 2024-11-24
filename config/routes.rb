Rails.application.routes.draw do
  post 'sign_in', to: 'sessions#create'
  delete 'sign_out', to: 'sessions#destroy'
  get 'profile', to: 'users#profile'
  get 'stocks/price_all', to: 'stocks#price_all'


  namespace :admin do
    resources :users, only: [:create, :update]
    patch 'user_wallets/:user_id', to: 'user_wallets#update'
    resources :teams, only: [:create]
  end

  resources :transactions, only: [:create]
  resources :stocks, only: [:create]
end
