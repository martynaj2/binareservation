class HallsController < ApplicationController

  def new
    @hall = Hall.new
  end

  def index
    @halls = Hall.all
  end

  def create
    @hall = Hall.new(hall_params)
      if @hall.save
        redirect_to halls_path, notice: 'Room created'
      else
        redirect_to halls_path, alert: 'Something went wrong'
      end
  end

  def show
    @hall = Hall.find(params[:id])
  end

  private

  def hall_params
      params.require(:hall).permit(:title, :capacity)
  end



end
