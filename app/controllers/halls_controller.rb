class HallsController < ApplicationController
  before_action :authenticate_user!

  def index
    @halls = Hall.all
    @halls = @halls.small unless params[:small].blank?
    @halls = @halls.large unless params[:large].blank?
    @halls = @halls.medium unless params[:medium].blank?
    @halls = @halls.extra_large unless params[:extra_large].blank?
  end

  def show
    @hall = Hall.find(params[:id])
    @reservations = Reservation.where(hall_id: @hall.id)
  end

  def edit
    @hall = Hall.find(params[:id])
  end

  def update
    @hall = Hall.find(params[:id])
      if @hall.update(hall_params)
        redirect_to halls_path,  notice: 'Room was updated'
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
    @hall = Hall.find(params[:id])
    if @hall.destroy
      redirect_to halls_path, notice: "Room deleted"
    else
      redirect_to halls_path, alert: "Something went wrong"
    end
  end

  private

  def hall_params
      params.require(:hall).permit(:title, :capacity)
  end

end
