class ReservationMailer < ApplicationMailer
  def quarter_notification_mail(user, reservation, invitor)
    return if user.vacation
    @user = user
    @reservation = reservation
    @invitor = invitor
    mail(to: user.email, subject: 'You will have meeting in 15 minutes')
  end

  def twenty_four_notification_mail(user, reservation, invitor)
    return if user.vacation
    @user = user
    @reservation = reservation
    @invitor = invitor
    mail(to: user.email, subject: 'You will have meeting in 24 hours')
  end

  def overwrite_mail(user, premium_user, reservation)
    @user = user
    @premium_user = premium_user
    @reservation = reservation
    mail(to: @user.email, subject: "Something has changed with #{@reservation.title}")
  end

  def invitation_mail(user, reservation, invitor)
    return if user == invitor
    @user = user
    @reservation = reservation
    @invitor = invitor
    mail(to: @user.email,
         subject: "Hello #{@user.fullname}. You have one new invitation ")
  end

  def cancelation_mail(user, reservation, invitor)
    @user = user
    @reservation = reservation
    @invitor = invitor
    mail(to: @user.email, subject: "#{@reservation.title} was canceled")
  end

  def update_mail(user, reservation, invitor)
    @user = user
    @reservation = reservation
    @invitor = invitor
    mail(to: @user.email, subject: "#{@reservation.title} was changed")
  end
end
