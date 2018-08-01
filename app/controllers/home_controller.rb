class HomeController < ApplicationController
  def welcome
    @rooml = Hall.large
    @rooms = Hall.small
    @roomm = Hall.medium
    @roomxl = Hall.extra_large
    @reservations = Reservation.not_ended
  end

  def index
    @rooml = Hall.large
    @rooms = Hall.small
    @roomm = Hall.medium
    @roomxl = Hall.extra_large
    @reservations = Reservation.not_ended
  end
end
