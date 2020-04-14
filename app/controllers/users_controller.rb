class UsersController < ApplicationController
  def index
    if params[:q] != nil
      @q = User.search(search_params)
      @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
    else
      @users = User.all.order(created_at: :desc).page(params[:page]).per(10)
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.order(created_at: :desc).page(params[:page]).per(10)
    @following_users = @user.following_user.all.order(created_at: :desc).page(params[:page]).per(10)
    @follower_users = @user.follower_user.all.order(created_at: :desc).page(params[:page]).per(10)
    @favorited_posts = @user.favorited_posts.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to @user
  	else
  		render 'edit'
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction, :prefecture)
  end

  def search_params
    params.require(:q).permit(:name_or_introduction_cont)
  end
end
