class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_guest_user, only: [:destroy], if: :devise_controller? # ゲストユーザーのアカウント削除制限
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  # かんたんログイン時の指定ユーザーID
  GUEST_ID = 13

  # kaminari表示数
  MYPAGE = 5
  INDEX = 10
  TAG = 15

  protected

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile_image, :introduction])
  end

  def check_guest_user # ゲストユーザーのアカウント削除制限
    if controller_name == 'registrations' && current_user.id == GUEST_ID
      redirect_to edit_user_path(current_user)
      flash[:warning] = "ゲストユーザーのためアカウント削除できません。"
    end
  end
end
