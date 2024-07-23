Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end

  root to: 'homes#top'
  get '/about', to: 'homes#about', as: 'about'
  resources :parks do
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :create, :index]
  resources :comments, only: [:create]
end
