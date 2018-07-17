class ReservationHall < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :hall
end
