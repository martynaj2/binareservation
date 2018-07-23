class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :password, :password_confirmation)}
			update_attrs = [:password, :password_confirmation, :current_password]
			devise_parameter_sanitizer.permit :account_update, keys: update_attrs
		end

	def authenticate_admin!
		if user_signed_in?
			unless current_user.is_admin?
				redirect_to root_url
			end
		else
			redirect_to root_url
		end
	end

end
