Rails.application.routes.draw do
  get '/merchants/:id/dashboard', to: 'merchants#show'

  get '/merchants/:id/items', to: 'items#index'
  get '/merchants/:id/items/new', to: 'items#new'
  post '/merchants/:id/items', to: 'items#create'
  get '/merchants/:id/items/:id', to: 'items#show'
  get '/merchants/:id/items/:id/edit', to: 'items#edit'
  patch '/merchants/:id/items/:id', to: 'items#update'

  get '/merchants/:id/invoices', to: 'invoices#index'
  get '/merchants/:id/invoices/:id', to: 'invoices#show'

  # namespace :merchants do
  #   get '/:id/items', to: 'items#index'
  #   get '/:id/items/new', to: 'items#new'
  #   post '/:id/items', to: 'items#create'
  #   get '/:id/items/:id', to: 'items#show'
  #   get '/:id/items/:id/edit', to: 'items#edit'
  #   patch '/:id/items/:id', to: 'items#update'
  #   get '/:id/invoices', to: 'invoices#index'
  #   get '/:id/invoices/:id', to: 'invoices#show'
  # end

  resources :admin, only: [:index]


  namespace :admin do
    resources :invoices, only: [:index, :show]
    resources :merchants, only: [:index, :show]
  end
end
