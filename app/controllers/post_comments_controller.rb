class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comments = @post.post_comments.all
    if @post_comment.save
      @post.create_notification_comment!(current_user, @post_comment.id)
      flash.now[:success] = "コメントを保存しました。"
    else
      flash.now[:danger] = "コメントは1〜100文字で入力してください。"
      render 'posts/show'
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    flash[:success] = "コメントを削除しました。"
    redirect_to post_path(@post_comment.post_id)
  end

  def update
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comments = @post.post_comments.all
    if @post_comment.update(post_comment_params)
      flash.now[:success] = "コメントを保存しました。"
    else
      flash.now[:danger] = "コメントは1〜100文字で入力してください。"
      render 'posts/show'
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
