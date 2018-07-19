class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new(hall_id: params[:hall_id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to reservations_path, notice: 'Reservation Updated'
    else
      render :edit
    end
  end

  def create
    # @reservation = Reservation.new(reservation_params)
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.save
      redirect_to reservations_path, notice: 'Reservation was created'
    else
       redirect_to reservations_path, alert: "Something went wrong"

    end
  end


  def destroy
      @reservation = Reservation.find(params[:id])
      @reservation.destroy
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :title, :description, :number_of_people, :start_date, :end_date, :hall_id)
    # ).merge(user_id: current_user.id)
  end
end
