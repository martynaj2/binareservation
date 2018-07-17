class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end
  
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to halls_path, notice: 'Reservation was created.'
    else
       redirect_to halls_path, alert: 'bla bla bla'
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:title, :description, :number_of_people, :start_date, :end_date, :inviter)
  end
end
