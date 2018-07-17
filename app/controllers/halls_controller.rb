class HallsController < ApplicationController

  def index
    @halls = Hall.all
  end

  def show
    @hall = Hall.find(params[:id])
  end

  def new
    @hall = Hall.new
  end

  def edit
    @hall = Hall.find(params[:id])
  end

  def update
    @hall = Hall.find(params[:id])
      if @hall.update(hall_params)
        redirect_to halls_path,  notice: 'Author was updated'
      else
        render :edit
      end
  end

  def create
    @hall = Hall.new(hall_params)
      if @hall.save
        redirect_to halls_path, notice: 'Room created'
      else
        redirect_to halls_path, alert: 'Something went wrong'
      end
  end

  def destroy
    hall = Hall.find(params[:id])
    if hall.destroy
      redirect_to halls_path, notice: 'Post was deleted'
    else
      redirect_to halls_path, alert: 'Error'
    end
  end

  private

  def hall_params
      params.require(:hall).permit(:title, :capacity)
  end

end
