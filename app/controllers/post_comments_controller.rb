class PostCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@post_comment = @post.post_comments.new(post_comment_params)
		@post_comment.user_id = current_user.id
		@post_comment.save
	end

	def destroy
		@post_comment = PostComment.find(params[:id])
		@post_comment.destroy
		redirect_to post_path(@post_comment.post_id)
	end

	def update
		@post = Post.find(params[:post_id])
		@post_comment = PostComment.find(params[:id])
		@post_comment.update(post_comment_params)
	end

	private
	def post_comment_params
		params.require(:post_comment).permit(:comment)
	end
end
