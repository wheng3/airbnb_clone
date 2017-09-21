class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validates :start_date, uniqueness: {scope: :end_date}
end