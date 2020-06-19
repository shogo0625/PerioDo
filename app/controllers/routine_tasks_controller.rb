class RoutineTasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create, :update, :destroy, :destroy_all]
  before_action :set_routine, only: [:create, :update, :destroy, :destroy_all]
  before_action :set_routine_task, only: [:update, :destroy]
  before_action :set_routine_tasks, only: [:create, :update, :destroy, :destroy_all]

  def create
    @routine_task = @routine.routine_tasks.new(routine_task_params)
    @routine_task.save
  end

  def update
    @routine_task.update(routine_task_params)
  end

  def destroy
    @routine_task.destroy
  end

  def destroy_all
    @routine_tasks.destroy_all
    flash[:success] = "全てのタスクを削除しました。"
    redirect_to edit_user_routine_path(@user, @routine)
  end

  private

  def routine_task_params
    params.require(:routine_task).permit(:content, :time)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_routine
    @routine = Routine.find(params[:routine_id])
  end

  def set_routine_task
    @routine_task = RoutineTask.find(params[:id])
  end

  def set_routine_tasks
     # 遷移元ページから非同期処理　jsファイルに渡すため定義
    @routine_tasks = @routine.routine_tasks.order(time: :asc)
  end
end
