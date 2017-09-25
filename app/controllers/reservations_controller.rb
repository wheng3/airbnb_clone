class ReservationsController < ApplicationController
	def create
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.new(reservation_from_params)
		@reservation.user_id = current_user.id
		@reservation.listing_id = @listing.id

		if @reservation.save
			current_user.reservations << @reservation
			@listing.reservations << @reservation
			flash[:success] = "Successfully created reservation."
			redirect_to '/'
		else
			@errors = @reservation.errors.full_messages
			flash[:error] = @errors
			redirect_back(fallback_location: root_path)
		end
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		if @reservation.destroy
			flash[:success] = "Successfully deleted your reservation"
			redirect_back(fallback_location: root_path)
		else
			flash[:error] = "Failed to delete your reservation"
			redirect_back(fallback_location: root_path)
		end
	end

	def reservation_from_params
		params.require(:reservation).permit(:start_date, :end_date, :occupant_number)
	end
end