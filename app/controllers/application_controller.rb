class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  PER_MYPAGE = 5
  PER_INDEX = 10

	protected
  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduction, :prefecture])
	end
end
