class UsersController < ApplicationController
  def index
    if params[:q] != nil
      @q = User.search(search_params)
      @users = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(PER_INDEX)
      @search_word = @q.name_or_introduction_cont
    else
      @users = User.all.order(created_at: :desc).page(params[:page]).per(PER_INDEX)
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.order(created_at: :desc).page(params[:page]).per(PER_MYPAGE)
    @following_users = @user.following_user.all.order(created_at: :desc).page(params[:page]).per(PER_MYPAGE)
    @follower_users = @user.follower_user.all.order(created_at: :desc).page(params[:page]).per(PER_MYPAGE)
    @favorited_posts = @user.favorited_posts.all.order(created_at: :desc).page(params[:page]).per(PER_MYPAGE)

    return unless request.xhr?

    case params[:type]
    when 'tab1', 'tab2', 'tab3', 'tab4'
      render "users/#{params[:type]}"
    end
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
