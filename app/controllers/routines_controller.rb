class RoutinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_routine, only: [:show, :edit, :update, :destroy]

  def index
  	@routines = @user.routines.where(status: 0)
  	@routine_records = @user.routines.where(status: 1)
  end

  def show
  	@routine_tasks = @routine.routine_tasks.all
  	@array = []
  	@routine_tasks.each do |task|
  		if @routine_tasks.exists?(routine_id: @routine.id, id: task.id + 1)
  			@next_task = @routine.routine_tasks.find(task.id + 1)
  		else
  			@next_task = @routine.routine_tasks.find(task.id)
  		end
  		@array.push([task.content, task.time, @next_task.time])
  	end
  end

  def new
  	unless @user.id == current_user.id
  		flash[:danger] = "ご指定のページにはアクセスできません。"
  		redirect_to new_user_routine_path(current_user)
  	end
	  @routine = @user.routines.new
	  @premade_task = @user.premade_tasks.new
	  @premade_tasks = @user.premade_tasks.all
	  @done_tasks = @user.tasks.where(status: 2)
	  if params[:flag] && @done_tasks.count == 0
	  	flash[:warning] = "完了したタスクが一つもありません。"
	  	redirect_to root_path
	  end 
  	if params[:flag] == "Record"
	  	@premade_tasks.destroy_all
	  	@done_tasks.each do |done_task|
	  		pretask = @user.premade_tasks.new
	  		pretask.content = done_task.content
	  		pretask.time = done_task.time_limit
	  		pretask.save
	  	end
		  @routine = @user.routines.new(status: 1)
	  	@premade_tasks = @user.premade_tasks.all
	  	flash.now[:success] = "今日終えたタスクを追加しました。TitleとCommentを入力して行動を記録しましょう！"
	  end
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
				flash[:success] = "「#{@routine.title}」が登録されました。"
				redirect_to user_routine_path(@user, @routine)
			else
				render 'new'
			end
		else
			flash.now[:danger] = "1つ以上のタスクを登録してください。"
			render 'new'
		end
  end

  def edit
    unless @user.id == current_user.id
  		flash[:danger] = "ご指定のページにはアクセスできません。"
  		redirect_to user_routines_path(current_user)
  	end
	  @routine_task = @routine.routine_tasks.new
	  @routine_tasks = @routine.routine_tasks.all
  end

  def update
  	@routine_tasks = @routine.routine_tasks.all
   	if @routine_tasks.count > 0
	  	if @routine.update(routine_params)
				flash[:success] = "「#{@routine.title}」が更新されました。"
				redirect_to user_routine_path(@user, @routine)
			else
				render 'edit'
			end
		else
			flash.now[:danger] = "1つ以上のタスクを登録してください。"
			render 'edit'
		end
  end

  def destroy
  	@routine.destroy
  	flash[:success] = "「#{@routine.title}」を削除しました。"
  	redirect_to user_routines_path(@user)
  end

  private

  def routine_params
  	params.require(:routine).permit(:title, :comment, :status)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_routine
  	@routine = Routine.find(params[:id])
  end
end
