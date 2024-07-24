Rails.application.routes.draw do
  namespace :admin do
    get 'comments/index'
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
  end

  root to: 'homes#top'
  get '/about', to: 'homes#about', as: 'about'
  resources :parks do
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :create, :index]
  resources :comments, only: [:create]
end
