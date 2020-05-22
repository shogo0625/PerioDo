class RoutinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_routine, only: [:show, :edit, :update, :destroy]

  def index
    @routines = @user.routines.where(status: 0).order(created_at: :desc).page(params[:page]).per(MYPAGE)
    @routine_records = @user.routines.where(status: 1).order(created_at: :desc).page(params[:page]).per(MYPAGE)

    return unless request.xhr?

    case params[:status]
    when 'routine_lists', 'record_lists'
      render "routines/#{params[:status]}"
    end
  end

  def show
    @routine_tasks = @routine.routine_tasks.all.order(time: :asc)
    @array = []
    @routine_tasks.each do |task|
      @array.push([task.content, task.time]) #chartkickに渡す多重配列を作成 最終的に渡す形式 = [['内容', '開始時間', '終了時間'], ...]
    end
    t = 0
    n = 1
    @array.each do |array|
      if @array[n]
        @array[t][2] = @array[n][1] # 一つ後のの配列内の'開始時間'を'終了時間'として設定
        n += 1
        t += 1
      else
        range = Routine.where(finish_time: '2000-01-01 00:00:00'..'2000-01-01 09:59:59') # 終了時間が24時超えたらdefaultの翌日に変換
        if range.include?(@routine)
          @array[-1][2] = '2000-01-02 ' + (l @routine.finish_time, format: :combine) + " +0900"
        else
          @array[-1][2] = @routine.finish_time #一つ後の配列がない(Routineの最後のタスク)場合、Routine自体の終了時間を代入
        end
      end
    end
  end

  def new
    unless @user.id == current_user.id
      flash[:danger] = "ご指定のページにはアクセスできません。"
      redirect_to new_user_routine_path(current_user)
    end
    @routine = @user.routines.new
    @premade_task = @user.premade_tasks.new
    @premade_tasks = @user.premade_tasks.all.order(time: :asc)
    @done_tasks = @user.tasks.where(status: 2).order(time_limit: :asc)
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
      @premade_tasks = @user.premade_tasks.all.order(time: :asc)
      flash.now[:success] = "今日終えたタスクを追加しました。TitleとCommentを入力して行動を記録しましょう！"
    end
  end

  def create
    @premade_tasks = @user.premade_tasks.all.order(time: :asc)
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
    @routine_tasks = @routine.routine_tasks.all.order(time: :asc)
  end

  def update
    @routine_tasks = @routine.routine_tasks.all.order(time: :asc)
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
    params.require(:routine).permit(:title, :comment, :status, :finish_time)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_routine
    @routine = Routine.find(params[:id])
  end
end
