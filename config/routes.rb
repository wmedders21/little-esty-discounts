Rails.application.routes.draw do

  resources :merchants do
    resources :items
    resources :invoices
  end

  get '/merchants/:id/dashboard', to: 'merchants#show'

  resources :admin, only: [:index]

  namespace :admin do
    resources :invoices, only: [:index, :show, :update]
    resources :merchants, only: [:index, :show]
  end
end
