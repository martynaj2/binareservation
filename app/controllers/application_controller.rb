class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :surname, :email, :password,
        :password_confirmation, :remember_me, :avatar, :avatar_cache, :remove_avatar)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :surname, :email, :password,
        :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar)
    end
  end

  def authenticate_admin!
    redirect_to root_path unless current_user&.admin?
  end
end
