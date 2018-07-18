class HomeController < ApplicationController
	def welcome
		@roomc = Hall.large
	end
end
