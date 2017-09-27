class ListingsController < ApplicationController
	def index
		@listings = Listing.order(created_at: :desc).page(params[:page]).per(8)
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
		params.require(:listing).permit(:name, :bed_number, :bathroom_number, :guest_number, 
			:address, :city, :price, :description, {photos: []}).merge(user_id: params['user_id'])
	end

	def show
		@listing = Listing.find_by(user_id: params[:user_id], id: params[:id])
		@reservation = @listing.reservations.new
	end

	def edit
		@listing = Listing.find(params[:id])
		@user = current_user
	    if current_user == User.find(params[:user_id]) and @listing.user == current_user
	      render template: "listings/edit"
	    else
	      redirect '/'
	      flash[:faliure] = "Sorry you can't edit other users' listings"
	    end
	end

	def update
		@listing = Listing.find(params[:id])
		if @listing.update_attributes(listing_from_params)
			flash[:success] = "Successfully updated your listing"
			redirect_to listings_path
		else
			flash[:error] = "Failed to edit your listing"
			redirect_to listings_path
		end
	end

	def destroy
		@listing = Listing.find(params[:id])
		if @listing.destroy
			flash[:success] = "Successfully deleted your listing"
			redirect_back(fallback_location: root_path)
		else
			flash[:error] = "Failed to delete your listing"
			redirect_back(fallback_location: root_path)
		end
	end

end