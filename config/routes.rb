Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  get 'search' => 'search#search'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts do
  	resources :post_comments, only: [:create, :update, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
end
