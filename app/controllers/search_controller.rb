class SearchController < ApplicationController

	PER_TAG = 15

  def search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)

    @search = Post.ransack(params[:search], search_key: :search)
    @posts = @search.result(distinct: true)

	  @tags = Tag.all.joins(:post_tags).group(:tag_id).order('count(tag_id) desc').page(params[:page]).per(PER_TAG)

	  return unless request.xhr?
	  render '/search/tags'

	 end

end
