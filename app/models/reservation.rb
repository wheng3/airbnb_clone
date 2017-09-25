class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing
	validates :occupant_number, numericality: { greater_than_or_equal_to: 0 }
	validate :valid_period?
	validate :overlapping_dates?
	validate :exceed_guest_number?

	def valid_period?
		if self.start_date >= self.end_date
			errors.add(:base, "Your reservation period is invalid")
		end
	end

	def overlapping_dates?
		self.listing.reservations.each do |reservation|
			if ((reservation.start_date<=self.start_date and reservation.end_date>=self.start_date) or
				(reservation.start_date<=self.end_date and reservation.end_date>=self.end_date))
				errors.add(:base, "Sorry, dates conflict with our current reservations")
				break
			end
		end
	end

	def exceed_guest_number?
		if self.occupant_number > self.listing.guest_number
			errors.add(:base, "Sorry, you have exceeded the maximum number of guests allowed")
		end
	end
end