class HomeController < ApplicationController
	def welcome
		@rooml = Hall.large
		@rooms = Hall.small
	end

	def index
		@reservations = Reservation.not_ended
	end
end
