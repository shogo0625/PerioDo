class RoutinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]

  def index
  	@routines = @user.routines.where(status: 0)
  	@routine_records = @user.routines.where(status: 1)
  end

  def show
  end

  def new
  	unless @user.id == current_user.id
  		flash[:danger] = "ご指定のページにはアクセスできません。"
  		redirect_to new_user_routine_path(current_user)
  	end
  	@routine = @user.routines.new
  	@premade_task = @user.premade_tasks.new
  	@premade_tasks = @user.premade_tasks.all
  end

  def create
   	@premade_tasks = @user.premade_tasks.all
  	@routine = @user.routines.new(routine_params)
   	if @premade_tasks.count > 0
	  	if @routine.save
		  	@premade_tasks.each do |pretask|
		  		@routine_task = @routine.routine_tasks.new
		  		@routine_task.content = pretask.content
		  		@routine_task.time = pretask.time
		  		@routine_task.save
		  		pretask.destroy
				end
				flash[:success] = "ルーティーンが登録されました。"
				redirect_to user_routine_path(@user, @routine)
			else
				render 'new'
			end
		else
			flash[:danger] = "1つ以上のタスクを登録してください。"
			render 'new'
		end
  end

  def edit
    unless @user.id == current_user.id
  		flash[:danger] = "ご指定のページにはアクセスできません。"
  		redirect_to user_routines_path(current_user)
  	end
  end

  def update
  	
  end

  def destroy
  	
  end

  private

  def routine_params
  	params.require(:routine).permit(:title, :comment, :status)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
