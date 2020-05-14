Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update, :index]

  resources :books, only: [:edit, :show, :create, :update, :index]

  root to: 'homes#top'
  get 'home/about' => 'homes#about'
end
