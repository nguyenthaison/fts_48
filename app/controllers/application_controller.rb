class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :chatwork_id]
    devise_parameter_sanitizer.for(:account_update) << [:name, :chatwork_id, :email,
      :password, :password_confirmation, :current_password]
  end

  def after_sign_in_path_for resource
    if current_user.normal?
      user_questions_path current_user
    else
      root_path
    end
  end
end
