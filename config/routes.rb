Rails.application.routes.draw do
  root "static_pages#home"
  get "home" => "static_pages#home"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users, only: [:update, :edit, :show]
  
  namespace :admin do
    resources :users, except: [:show, :update, :edit]
    resources :subjects
  end
end
