class Listing < ApplicationRecord
	include Filterable
	mount_uploaders :photos, PhotoUploader
	belongs_to :user
	has_many :reservations, dependent: :destroy
	scope :city, -> (city) { where city: city }
	scope :bed_number, -> (bed_number) { where('bed_number >= ?', bed_number) }
	scope :bathroom_number, -> (bathroom_number) { where('bathroom_number >= ?', bathroom_number) }
	scope :price_min, -> (price_min) { where('price >= ?', price_min) }
	scope :price_max, -> (price_max) { where('price <= ?', price_max) }
end