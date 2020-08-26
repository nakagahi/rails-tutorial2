Rails.application.routes.draw do

  resources :users

  get '/sign_up', to: "users#new"

# statick_pages
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  root 'static_pages#home'
end
