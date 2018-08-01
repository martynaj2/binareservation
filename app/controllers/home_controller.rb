class HomeController < ApplicationController
  def index
    @rooml = Hall.large
    @rooms = Hall.small
    @roomm = Hall.medium
    @roomxl = Hall.extra_large
    @reservations = Reservation.not_ended
  end
end
