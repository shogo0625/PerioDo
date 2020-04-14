class SearchController < ApplicationController
  def search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    @users = @users.order(created_at: :desc).page(params[:page]).per(10)

    @search = Post.ransack(params[:search], search_key: :search)
    @posts = @search.result(distinct: true)
    @posts = @posts.order(created_at: :desc).page(params[:page]).per(5)
  end
end
