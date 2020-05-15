Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#top'
  get 'home/about'

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    resources :routines do
      resources :routine_tasks, only: [:create, :update, :destroy]
    end
  end
  resources :premade_tasks, only: [:create, :update, :destroy]
  post '/users/new_guest' => 'users#new_guest', as: 'new_guest' # ゲストユーザーログイン用ルート
  patch '/users/:id/delete_profile_image' => 'users#delete_profile_image', as: 'delete_profile_image'
  resources :posts do
    resources :post_comments, only: [:create, :update, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :tasks, only: [:create, :update, :destroy]
  get 'search' => 'search#search'
  get '/posts/tag/:name' => "posts#hashtag", as: 'posts_tag'
  patch '/posts/:id/delete_post_image' => 'posts#delete_post_image', as: 'delete_post_image'

  post 'follow/:id' => 'relationships#create', as: 'follow'
  delete 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'
end
