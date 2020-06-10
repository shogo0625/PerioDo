class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search].present?
      @search = Post.search(search_params)
      @posts = @search.result(distinct: true).order(created_at: :desc).page(params[:page]).per(INDEX)
      @posts_count = @search.result(distinct: true)
      @search_word = @search.content_cont
    else
      @posts = Post.order(created_at: :desc).page(params[:page]).per(INDEX)
    end
  end

  def new
    @post = Post.new
    @tag_name = "　#" + params[:tag_name] if params[:tag_name].present?
    @task = Task.find(params[:task_id]) if params[:task_id].present?
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      sleep(3) if @post.image_id.present? # S3への画像反映のタイムラグを考慮して3秒待機
      flash[:success] = "あなたのヒトコトが投稿されました。"
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end

  def edit
    screen_user(@post)
  end

  def update
    if @post.update(post_params)
      sleep(3) if @post.image_id.present? # S3への画像反映のタイムラグを考慮して3秒待機
      flash[:success] = "あなたのヒトコトが更新されました。"
      redirect_to @post
    else
      render :edit
    end
  end

  def delete_post_image
    @post = Post.find(params[:id])
    screen_user(@post)
    @post.update_column(:image_id, nil)
    flash[:success] = "投稿内の画像を削除しました。"
    redirect_to edit_post_path(@post)
  end

  def destroy
    screen_user(@post)
    @post.destroy
    flash[:success] = "ヒトコトを削除しました。"
    redirect_to user_path(current_user)
  end

  def hashtag
    @tag = Tag.find_by(name: params[:name])
    @posts = @tag.posts.order(created_at: :desc).page(params[:page]).per(INDEX)
    @posts_count = @tag.posts
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
