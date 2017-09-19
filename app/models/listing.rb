class Listing < ApplicationRecord
	mount_uploaders :photos, PhotoUploader
	belongs_to :user
end