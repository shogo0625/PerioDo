class HomeController < ApplicationController
  def top
    @user = current_user
    (@posts = Post.order(created_at: :desc).page(params[:page]).per(INDEX)) && return if @user.nil?
    # 以下、ログインユーザーの場合のタイムライン表示＆タスク表示
    @users = current_user.following_user
    timeline_posts = [] # 空の配列定義
    @users.each do |user|
      posts = user.posts
      timeline_posts.concat(posts) # フォローしているユーザーのポストを空の配列に代入・結合していく
    end
    my_posts = current_user.posts
    timeline_posts.concat(my_posts) # 選択されたユーザーの投稿も結合　タイムライン表示
    timeline_posts = timeline_posts.sort_by { |post| post.created_at }.reverse
    @posts = Kaminari.paginate_array(timeline_posts).page(params[:page]).per(INDEX)

    @task = @user.tasks.new
    @todo_tasks = @user.tasks.where(status: 0).order(time_limit: :asc)
    @doing_tasks = @user.tasks.where(status: 1).order(time_limit: :asc)
    @done_tasks = @user.tasks.where(status: 2).order(time_limit: :asc)
  end

  def about
  end
end
