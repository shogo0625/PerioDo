class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :screen_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def index
    if !params[:q].nil?
      @q = User.search(search_params)
      @users = @q.result(distinct: true).page(params[:page]).per(INDEX)
      @search_word = @q.name_or_introduction_cont
    else
      @users = User.all.page(params[:page]).per(INDEX)
    end
  end

  def show
    @posts = @user.posts.all.page(params[:page]).per(MYPAGE)
    @following_users = @user.following_user.all.page(params[:page]).per(MYPAGE)
    @follower_users = @user.follower_user.all.page(params[:page]).per(MYPAGE)
    @favorited_posts = @user.favorited_posts.all.page(params[:page]).per(MYPAGE)

    return unless request.xhr?

    case params[:type]
    when 'tab1', 'tab2', 'tab3', 'tab4'
      render "users/#{params[:type]}"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      sleep(3) unless @user.profile_image_id == nil # S3への画像反映のタイムラグを考慮して3秒待機
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def delete_profile_image
    @user = User.find(params[:id])
    @user.update_column(:profile_image_id, nil)
    flash[:success] = "プロフィール画像を削除しました。"
    redirect_to edit_user_path(@user)
  end

  def new_guest #ポートフォリオ閲覧用ユーザーログイン
    @user = User.find(GUEST_ID)
    sign_in @user
    flash[:success] = "閲覧ありがとうございます！ゲストユーザーとしてログインしました。"
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :introduction, :prefecture)
  end

  def search_params
    params.require(:q).permit(:name_or_introduction_cont)
  end

  def screen_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
