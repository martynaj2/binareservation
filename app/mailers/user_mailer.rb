class UserMailer < ApplicationMailer
	def hello_mail(user)
		@user = user
		mail(to: user.email, subject: "Thank you for registration")
	end
end

#UserMailer.hello_mail(current_user).deliver_later
#UserMailer.with(user: current_user).hello_mail.deliver_later
