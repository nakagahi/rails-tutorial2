Rails.application.routes.draw do


  resources :microposts, only: [:create, :destroy]

  resources :password_resets, only: [:new, :edit, :create, :update]
  resources :account_activations, only: [:edit]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  get '/sign_up', to: "users#new"


# statick_pages
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  root 'static_pages#home'
end
