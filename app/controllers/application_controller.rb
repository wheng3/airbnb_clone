class ApplicationController < ActionController::Base
	include Clearance::Controller
	protect_from_forgery with: :exception

	def allowed?(action:, user:)
		if(action == 'superadmin_secret' and user.superadmin?)
			flash[:kappa] = 'Kappa!'
			redirect_to 'https://i.imgur.com/0yawnTO.gif'
		else
			flash[:failed] = 'Sorry you are not Super Admin...'
			redirect_to '/'
		end
	end
end
