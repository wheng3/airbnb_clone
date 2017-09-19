class ListingsController < ApplicationController
	def index
		@listings = Listing.page(params[:page]).per(10)
	end

	def new
		if !current_user.customer?
			flash[:notice] = "Sorry. You are not allowed to perform this action."
			redirect_to '/'
		end
	end

	def create
		@listing = Listing.new(listing_from_params)
		if @listing.save
			flash[:notice] = "Successfully created listing."
			redirect_to '/'
		else
			flash[:notice] = "Failed to create listing."
			render template: "listings/new"
		end
	end

	def listing_from_params
		params.require(:listing).permit(:name, :property_type, :room_type, :room_number, :bed_number, 
			:guest_number, :country, :state, :city, :address, :price, :description, {photos: []}).merge(user_id: params['user_id'])
	end

end