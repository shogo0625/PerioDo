class RoutinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show, :new, :edit]

  def index
  	@routines = @user.routines.where(status: 0)
  	@routine_records = @user.routines.where(status: 1)
  end

  def show
  end

  def new
  	@routine = @user.routines.new
  	@new_premade_task = @user.premade_tasks.new
  	@premade_tasks = @user.premade_tasks.all
  end

  def edit
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end
end
