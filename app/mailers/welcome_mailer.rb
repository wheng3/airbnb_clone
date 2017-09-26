class WelcomeMailer < ApplicationMailer
	default from: ENV['GMAIL_USERNAME']

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to Airbnb Clone!')
	end
end
