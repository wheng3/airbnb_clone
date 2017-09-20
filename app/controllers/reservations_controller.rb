class ReservationsController < ApplicationController
	def create
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new(reservation_from_params)
		current_user.reservations << @reservation
		@listing.reservations << @reservation

		if @reservation.save
			flash[:success] = "Successfully created reservation."
			redirect_to '/'
		else
			flash[:error] = "Failed to create reservation."
			redirect_back(fallback_location: root_path)
		end
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
	end

	def reservation_from_params
		params.require(:reservation).permit(:start_date, :end_date, :occupant_number)
	end
end