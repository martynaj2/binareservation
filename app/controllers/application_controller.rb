class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :password, :password_confirmation)}
		end

		def authenticate_user!
			if user_signed_in?
				super
			else
				redirect_to root_url
				## if you want render 404 page
				## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
			end
		end
end
