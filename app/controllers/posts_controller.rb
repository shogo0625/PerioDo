class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if !params[:search].nil?
      @search = Post.search(search_params)
      @posts = @search.result(distinct: true).order(created_at: :desc).page(params[:page]).per(INDEX)
      @search_word = @search.content_cont
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(INDEX)
    end
  end

  def new
    @post = Post.new
    @tag_name = "　#" + params[:tag_name] unless params[:tag_name].nil?
    @task = Task.find(params[:task_id]) unless params[:task_id].nil?
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      sleep(3) # S3への画像反映のタイムラグを考慮して3秒待機
      flash[:success] = "あなたのヒトコトが投稿されました。"
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post_comment = PostComment.new
  end

  def edit
    screen_user(@post)
  end

  def update
    if @post.update(post_params)
      sleep(3) # S3への画像反映のタイムラグを考慮して3秒待機
      flash[:success] = "あなたのヒトコトが更新されました。"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "ヒトコトを削除しました。"
    redirect_to user_path(current_user)
  end

  def hashtag
    @tag = Tag.find_by(name: params[:name])
    @posts = @tag.posts.all.order(created_at: :desc).page(params[:page]).per(INDEX)
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def search_params
    params.require(:search).permit(:content_cont)
  end

  def screen_user(post)
    redirect_to posts_path unless post.user.id == current_user.id
  end
end
