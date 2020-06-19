class HomeController < ApplicationController
  def top
    @user = current_user
    (@posts = Post.order(created_at: :desc).page(params[:page]).per(INDEX)) && return if @user.nil?
    # タイムライン取得　フォローしているユーザーのポストと自分のポストを結合する
    @following_users = current_user.following_user
    timeline_posts = []
    @following_users.each do |user|
      posts = user.posts
      timeline_posts.concat(posts)
    end
    my_posts = current_user.posts
    timeline_posts.concat(my_posts).sort! { |post| post.created_at }.reverse
    @posts = Kaminari.paginate_array(timeline_posts).page(params[:page]).per(INDEX)
    # ToDoListのタスク　下3行でstatus毎に取得
    @task = @user.tasks.new
    @todo_tasks  = @user.select_tasks_by(status: 'ToDo')
    @doing_tasks = @user.select_tasks_by(status: 'Doing')
    @done_tasks  = @user.select_tasks_by(status: 'Done')
  end

  def about
  end
end
