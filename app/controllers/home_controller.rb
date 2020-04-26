class HomeController < ApplicationController
  def top
    @user = current_user
    if @user.present?
      @users = @user.following_user.all
      array = [] # 空の配列定義
      @users.each do |user|
        posts = Post.where(user_id: user.id)
        array.concat(posts) # @usersに対して繰り返し処理　空の配列に代入・結合していく
      end
      array = array.sort_by { |post| post.created_at }.reverse
      @posts = Kaminari.paginate_array(array).page(params[:page]).per(INDEX)

      @new_task = @user.tasks.new
      @todo_tasks = @user.tasks.where(status: 0)
      @doing_tasks = @user.tasks.where(status: 1)
      @done_tasks = @user.tasks.where(status: 2)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(INDEX)
    end
  end

  def about
  end
end
