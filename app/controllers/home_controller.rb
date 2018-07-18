class HomeController < ApplicationController
	def welcome
		@roomc = Hall.order(capacity: :desc).limit(2)
	end
end
