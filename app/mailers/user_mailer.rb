class UserMailer < ApplicationMailer
  def registration_mail(user)
    @user = user
    mail(to: user.email, subject: 'Thank you for registration')
  end

  def vacation_true_mail(user)
    @user = user
    mail(to: user.email, subject: 'You are on vacation, you will not get any emails from now on')
  end

  def vacation_false_mail(user)
    @user = user
    mail(to: user.email, subject: 'Welcome back, enjoyed your vacation?')
  end
end
