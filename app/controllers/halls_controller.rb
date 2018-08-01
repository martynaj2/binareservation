class HallsController < ApplicationController
  before_action :authenticate_user!

  def new
    @hall = Hall.new
  end

  def index
    @halls = Hall.all.paginate(page: params[:page], per_page: 5)
    @halls = @halls.small if params[:small].present?
    @halls = @halls.large if params[:large].present?
    @halls = @halls.medium if params[:medium].present?
    @halls = @halls.extra_large if params[:extra_large].present?
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
    @reservations = Reservation.not_ended.where(hall_id: @hall.id)
  end

  def edit
    @hall = Hall.find(params[:id])
  end

  def update
    @hall = Hall.find(params[:id])
    if @hall.update(hall_params)
      redirect_to halls_path, notice: 'Room was updated'
    else
      render :edit
    end
  end

  def destroy
    @hall = Hall.find(params[:id])
    if @hall.destroy
      redirect_to halls_path, notice: 'Room deleted'
    else
      redirect_to halls_path, alert: 'Something went wrong'
    end
  end

  private

  def hall_params
    params.require(:hall).permit(:title, :capacity)
  end
end
