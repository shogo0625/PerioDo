class PremadeTasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_premade_task, only: [:update, :destroy]
  before_action :set_premade_tasks, only: [:create, :update, :destroy, :destroy_all]

  def create
    @premade_task = current_user.premade_tasks.new(premade_task_params)
    @premade_task.save
  end

  def update
    @premade_task.update(premade_task_params)
  end

  def destroy
    @premade_task.destroy
  end

  def destroy_all
    @premade_tasks.destroy_all
    flash[:success] = "全てのタスクを削除しました。"
    redirect_to new_user_routine_path(current_user)
  end

  private

  def premade_task_params
    params.require(:premade_task).permit(:content, :time)
  end

  def set_premade_task
    @premade_task = PremadeTask.find(params[:id])
  end

  def set_premade_tasks # 遷移元ページから非同期処理　jsファイルに渡すため定義
    @premade_tasks = current_user.premade_tasks.order(time: :asc)
  end
end
