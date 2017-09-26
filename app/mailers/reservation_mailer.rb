class ReservationMailer < ApplicationMailer
	default from: ENV['GMAIL_USERNAME']

	def reservation_email_for_hoster(customer, host, reservation_id)
		@customer = customer
		@host = host
		@reservation = Reservation.find(reservation_id)

		@url  = 'http://example.com/login'
		mail(to: @host.email, subject: 'Someone booked your listing!')
	end
end