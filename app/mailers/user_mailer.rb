class UserMailer < ApplicationMailer
	def hello_mail(user)
		@user = user
		mail(to: user.email, subject: "Thank you for registration")
	end
end
