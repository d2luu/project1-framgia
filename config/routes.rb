Rails.application.routes.draw do
  root "static_pages#home"
  get "home" => "static_pages#home"
  namespace :admin do
    resources :users, except: [:show, :update, :edit]
  end
end
