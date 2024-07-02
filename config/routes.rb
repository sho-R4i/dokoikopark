Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root to: 'homes#top'
  get '/about', to: 'homes#about', as: 'about'
  resources :parks
  resources :users, only: [:show, :edit, :update, :create, :index]
end
