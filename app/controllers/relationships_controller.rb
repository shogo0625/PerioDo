class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.follow(params[:id])
    @user = User.find(params[:id]) # Ajax jsファイルに渡すため定義
    @user.create_notification_follow!(current_user)
  end

  def destroy
    current_user.unfollow(params[:id])
    @user = User.find(params[:id]) # Ajax jsファイルに渡すため定義
  end
end
