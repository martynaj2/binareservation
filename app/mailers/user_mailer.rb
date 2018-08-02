class UserMailer < ApplicationMailer
  def registration_mail(user)
    @user = user
    mail(to: user.email, subject: 'Thank you for registration')
  end

  def vacation_mail(user)
    @user = user
    mail(to: user.email, subject: 'You are on vacation, you will not get any emails from now on')
  end
end
