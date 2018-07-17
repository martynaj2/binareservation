class RegistrationsController < Devise::RegistrationsController

	before_action :configure_permitted_parameters, :only => [:create]

	protected

		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :password, :password_confirmation)}
		end
	# private
	#
	# def sign_up_params
	# 	params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
	# end
	#
	# def account_update_params
	# 	params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :current_password)
	# end

end
