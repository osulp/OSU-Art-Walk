Rails.application.routes.draw do
  root :to => "catalog#index"
  blacklight_for :catalog
  devise_for :users

  get '/admin', :to => 'admin#index', :as => "admin_index"
  namespace :admin do
    resources :users
  end
end
