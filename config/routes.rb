Rails.application.routes.draw do
  root "static_pages#home"
  get "home" => "static_pages#home"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  namespace :admin do
    resources :users, except: [:show, :update, :edit]
  end
  resources :users, only: [:update, :edit, :show]
end
