class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = current_user.posts.new(post_params)
  	if @post.save
  		redirect_to @post
  	else
  		render 'new'
  	end
  end

  def show
    @post_comment = PostComment.new
  end

  def edit
  	unless @post.user_id == current_user.id
  		redirect_to user_path(current_user)
  	end
  end

  def update
  	if @post.update(post_params)
  		redirect_to @post
  	else
  		render 'edit'
  	end
  end

  def hashtag
    @tag = Tag.find_by(name: params[:name])
    @posts = @tag.posts.all
  end

  private
  def post_params
  	params.require(:post).permit(:content, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
