Rails.application.routes.draw do
  root :to => "catalog#index"
  blacklight_for :catalog
  devise_for :users

  get '/admin', :to => 'admin#index', :as => "admin_index"

  get '/about', :to => 'about#index', :as => "about_us"
  namespace :admin do
    resources :users
    resources :art_pieces
    resources :artists
    resources :buildings
    resources :collections
    resources :settings
  end
end
