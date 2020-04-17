class HomeController < ApplicationController
  def top
  	@user = current_user
  	if @user.present?
	  	@users = @user.following_user.all
	  	array = []
	  	@users.each do |user|
	  		posts = Post.where(user_id: user.id)
	  		array.concat(posts)
	  	end
	  	array = array.sort_by{|post| post.created_at}.reverse
	  	@posts = Kaminari.paginate_array(array).page(params[:page]).per(PER_INDEX)
	  else
	  	@posts = Post.all.order(created_at: :desc).page(params[:page]).per(PER_INDEX)
	  end
  end

  def about
  end
end
