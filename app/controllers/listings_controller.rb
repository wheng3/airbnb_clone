class ListingsController < ApplicationController
  def index
    @listings = Listing.page(params[:page]).per(10)
  end
end
