class RelationshipsController < ApplicationController
	def create
		current_user.follow(params[:id])
		@user = User.find(params[:id]) #Ajax jsファイルに渡すため定義
	end

	def destroy
		current_user.unfollow(params[:id])
		@user = User.find(params[:id]) #Ajax jsファイルに渡すため定義
	end
end
