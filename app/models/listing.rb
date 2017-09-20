class Listing < ApplicationRecord
	mount_uploaders :photos, PhotoUploader
	belongs_to :user
	has_many :reservations, dependent: :destroy
end