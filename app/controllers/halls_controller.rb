class HallsController < ApplicationController

  def index
    @halls = Hall.all
  end

end
