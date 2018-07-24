class HomeController < ApplicationController
	def welcome
		@roomc = Hall.large
	end

	def index
		@reservations = Reservation.not_ended
	end
end
