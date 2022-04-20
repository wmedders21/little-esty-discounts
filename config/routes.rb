Rails.application.routes.draw do

  resources :merchants do
    resources :items
    resources :invoices
    resources :invoice_items
  end

  get '/merchants/:id/dashboard', to: 'merchants#show'

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants
    resources :invoices, only: [:index, :show, :update]
  end
end
