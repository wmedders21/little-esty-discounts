Rails.application.routes.draw do

  resources :merchants do
    get '/items', to: 'merchant_items#index'
    post '/items', to: 'merchant_items#create'
    get '/items/new', to: 'merchant_items#new'
    get '/items/:item_id/edit', to: 'merchant_items#edit'
    get '/items/:item_id', to: 'merchant_items#show'
    patch '/items/:item_id', to: 'merchant_items#update'
    delete '/items/:item_id', to: 'merchant_items#destroy'
    # resources :items
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
