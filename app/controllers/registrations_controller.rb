class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create]

  after_action :registration_mail, only: [:create]

  def create
    super
  end

  def registration_mail
    UserMailer.registration_mail(current_user).deliver_now
  end
end
