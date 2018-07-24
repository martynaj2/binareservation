class ReservationMailer < ApplicationMailer
	def quarter_notification_mail(user)
		@user = user
		mail(to: user.email, subject: "You will have meeting in 15 minutes")
	end

	def twenty_four_notification_mail(user)
		@user = user
		mail(to: user.email, subject: "You will have meeting in 24 hours")
	end

	def overwrite_mail(user, premium_user, reservation)
		@user = user
		@premium_user = premium_user
		@reservation = reservation
		mail(to: @user.email, subject: "Your meeting #{reservation.title} was overwritten by #{premium_user.fullname}")
	end

	def invitation_mail(reservation)
		@users_id = reservation.invited_ids
		@reservation = reservation
		@invitor = User.find(reservation.user_id)
		if @users_id.kind_of?(Array)
			@users_id.each do |m|
				@user = User.find(@users_id)
				mail(to: @user.email, subject: "Hello #{@user.fullname}. You were invited to #{reservation.title}, by #{@invitor.fullname}")
			end
		elsif @users_id.kind_of?(Integer)
			@user = User.find(@users_id)
			mail(to: @user.email, subject: "Hello #{@user.fullname}. You were invited to #{reservation.title}, by #{@invitor.fullname}")
		else

		end
	end
end
