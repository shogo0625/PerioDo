class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(params[:id])
    @user.create_notification_follow!(current_user)
  end

  def destroy
    current_user.unfollow(params[:id])
  end

  def set_user
    # 非同期処理 jsファイルに渡す
    @user = User.find(params[:id])
  end
end
