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
    reservations = Reservation.all
    @reservation = current_user.reservations.build(reservation_params)
    if reservations.empty?
      @valid = true
    else
      reservations.each do |r|
        if (@reservation.start_date <= r.start_date && @reservation.end_date >= r.start_date)
          @valid = true
        else
          @valid = false
        end
      end
    end

    if @valid == true
       if @reservation.save
         redirect_to reservations_path, notice: 'Reservation was created.'
       else
         redirect_to reservations_path, alert: "Something went wrong #{@reservation.errors.full_messages}"
       end
    else
      redirect_to reservations_path, alert: "Reservation conflict"
    end
  end


  def destroy
      @reservation = Reservation.find(params[:id])
      @reservation.destroy
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :title, :description, :number_of_people, :start_date, :end_date,:hall_id)
    # ).merge(user_id: current_user.id)
  end
end
