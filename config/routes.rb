Rails.application.routes.draw do

  resources :merchants do
    resources :items
    resources :invoices
  end

  get '/merchants/:id/dashboard', to: 'merchants#show'

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :edit]

    resources :invoices, only: [:index, :show, :update]
  end
end
