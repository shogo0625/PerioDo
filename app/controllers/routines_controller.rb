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
  end

  def edit
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end
end
