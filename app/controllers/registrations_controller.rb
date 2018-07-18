class RegistrationsController < Devise::RegistrationsController

	before_action :configure_permitted_parameters, :only => [:create]

	after_action :send_admin_mail, :only => [:create]

  def send_admin_mail
    UserMailer.hello_mail(current_user).deliver_later
  end

	protected

		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :password, :password_confirmation)}
		end

end
