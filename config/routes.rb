Rails.application.routes.draw do
  root "static_pages#home"
  get "home" => "static_pages#home"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
    
  namespace :admin do
    resources :users, except: [:update, :edit]
    resources :subjects
    resources :courses do
      resources :course_subjects, only: :show
    end
  end
  namespace :supervisor do
    resources :courses, only: [:index, :show] do
      resources :course_subjects, only: :show
    end
    resources :user_courses, only: :destroy
    resources :assign_users, only: [:edit, :update]
  end
  resources :users, only: [:show, :edit, :update] do
    resources :relationships, only: :index
  end
  resources :relationships, only: [:create, :destroy]
end
