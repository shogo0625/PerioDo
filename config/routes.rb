Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#top'
  get 'home/about'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts do
  	resources :post_comments, only: [:create, :update, :destroy]
  	resource :favorites, only: [:create, :destroy]
  end
  resources :tasks, only: [:create, :update, :destroy]
  get 'search' => 'search#search'
  get '/posts/tag/:name', to: "posts#hashtag", as: 'posts_tag'

  post 'follow/:id' => 'relationships#create', as: 'follow'
  delete 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'
end
