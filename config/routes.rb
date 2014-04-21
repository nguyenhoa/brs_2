Brs2::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :positions
  resources :teams
  namespace :admin do
  	match "/signin", to: "sessions#new", via: "get"
    match "/signout", to: "sessions#destroy", via: "delete"
  	resources "sessions", only: [:new, :create, :destroy]
  	resources "users"
  end
  root "static_pages#home"
  match "/help", to: "static_pages#help", via: "get"
  match "/about", to: "static_pages#about", via: "get"
  match "/contact", to: "static_pages#contact", via: "get" 
  match "/signin",  to: "sessions#new",         via: "get"
  match "/signout", to: "sessions#destroy",     via: "delete"
end
