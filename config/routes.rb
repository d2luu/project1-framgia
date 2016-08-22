Rails.application.routes.draw do
  root "static_pages#home"
  get "home" => "static_pages#home"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
    
  namespace :admin do
    root "static_pages#home"
    resources :users, except: [:update, :edit]
    resources :subjects
    resources :courses do
      resources :course_subjects, only: :show
    end
    resources :assign_supervisors, only: [:update, :edit]
  end
  namespace :supervisor do
    resources :courses, only: [:index, :show] do
      resources :course_subjects, only: :show do
        resources :active_subjects, only: :update
      end
      resource :active_courses, only: :update
    end
    resources :user_courses, only: :destroy
    resources :assign_users, only: [:edit, :update]
  end
  resources :users, only: [:show, :edit, :update] do
    resources :relationships, only: :index
    resources :courses, only: [:index, :show] do
      resources :course_subjects, only: [:show, :update]
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :courses, only: [:index, :show]
end
