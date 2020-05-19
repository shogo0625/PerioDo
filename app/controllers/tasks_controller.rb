class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:update, :destroy]
  before_action :set_tasks, only: [:create, :update, :destroy]

  def create
    if params[:routine_id]
      @routine = Routine.find(params[:routine_id])
      @routine.routine_tasks.each do |routine_task|
        @task = current_user.tasks.new
        @task.content = routine_task.content
        @task.time_limit = Date.current.strftime('%Y-%m-%d ') + (l routine_task.time, format: :combine)
        @task.save
      end
      flash[:success] = "スケジュールを【 ToDo 】に追加しました。今日も一日頑張りましょう！"
      redirect_to root_path
    else
      @task = current_user.tasks.new(task_params)
      @task.save
    end
    @new_task = current_user.tasks.new # create時のみjsファイルへ渡す
  end

  def update
    if params[:status].present?
      @task.update_columns(status: params[:status])
    else
      @task.update(task_params)
    end
  end

  def destroy
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit(:content, :time_limit, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_tasks # 遷移元topページから非同期処理　jsファイルに渡すため定義
    @todo_tasks = current_user.tasks.where(status: 0).order(time_limit: :asc)
    @doing_tasks = current_user.tasks.where(status: 1).order(time_limit: :asc)
    @done_tasks = current_user.tasks.where(status: 2).order(time_limit: :asc)
  end
end
