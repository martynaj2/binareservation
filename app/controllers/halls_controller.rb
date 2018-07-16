class HallsController < ApplicationController

  def index
    @halls = Hall.all
  end

  def show
    @hall = Hall.find(params[:id])
  end

  private

  def hall_params
      params.require(:hall).permit(:title, :capacity)
  end

end
