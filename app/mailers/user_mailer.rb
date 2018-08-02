class UserMailer < ApplicationMailer
  def registration_mail(user)
    @user = user
    mail(to: user.email, subject: 'Thank you for registration')
  end

  # def vacation_true_mail(user)
  #   @user = user
  #   mail(to: user.email, subject: 'Vacation time!')
  # end
  #
  # def vacation_false_mail(user)
  #   @user = user
  #   mail(to: user.email, subject: 'Welcome back! Ready for new meetings?')
  # end
end
