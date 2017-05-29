Rails.application.routes.draw do
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/home', to: 'static_pages#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/api', to: 'upc_api#create'

  resources :users
  resources :items, only: [ :index, :new, :create, :destroy, :update]
 
end
