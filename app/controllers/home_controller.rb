class HomeController < ApplicationController
  def welcome
    @rooml = Hall.large
    @rooms = Hall.small
    @roomm = Hall.medium
    @roomxl = Hall.extra_large
  end

  def index
    @reservations = Reservation.not_ended
  end
end
