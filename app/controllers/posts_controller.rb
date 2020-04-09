class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = current_user.posts.new(post_params)
  	if @post.save
  		redirect_to user_path(current_user)
  	else
  		redirect_to user_path(current_user)
  	end
  end

  def show
  end

  def edit
  	@post = Post.find(params[:id])
  	unless @post.user_id == current_user.id
  		redirect_to user_path(current_user)
  	end
  end

  def update
  	@post = Post.find(params[:id])
  	if @post.update(post_params)
  		redirect_to @post
  	else
  		render 'edit'
  	end
  end

  private
  def post_params
  	params.require(:post).permit(:content, :image)
  end
end
