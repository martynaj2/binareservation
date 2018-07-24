class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.all
  end

  def user_index
    @reservations = current_user.reservations
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new(hall_id: params[:hall_id], start_date: params[:start_date], end_date: params[:end_date])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    current_reservation = current_user.reservations.build(reservation_params)
    reservations = Reservation.where(hall_id: @reservation.hall_id).where.not(id: params[:id])
    @conflicting_reservations = Reservation.conflict_validation(reservations, current_reservation)
    if @conflicting_reservations.empty?
       if @reservation.update(reservation_params)
         redirect_to reservations_path, notice: 'Reservation Updated'
       else
         render :edit
       end
    else
      premium_override
    end
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    reservations = Reservation.where(hall_id: @reservation.hall_id)
    @conflicting_reservations = Reservation.conflict_validation(reservations, @reservation)
    if @conflicting_reservations.empty?
       if @reservation.save
         redirect_to reservations_path, notice: 'Reservation was created.'
       else
         redirect_to reservations_path, alert: "Something went wrong #{@reservation.errors.full_messages}"
       end
    else
      premium_override
    end
  end


  def destroy
      @reservation = Reservation.find(params[:id])
      if @reservation.destroy
        redirect_to reservations_path, notice: "Reservation was deleted"
      else
        redirect_to reservations_path, alert: "Something went wrong"
      end
  end

  def override
    @reservation = Reservation.new(session[:reservation_attributes])
    @conflicting_reservations = Reservation.conflict_validation(Reservation.where(hall_id: @reservation.hall_id), @reservation)
    @conflicting_reservations.each do |r|
      r.destroy
    end
    if @reservation.save
      redirect_to reservations_path, notice: 'Reservation was created.'
    else
      redirect_to reservations_path, alert: "Something went wrong #{@reservation.errors.full_messages}"
    end
    session.delete(:reservation_attributes)
  end

  def confirm
    @reservation = Reservation.new(session[:reservation_attributes])
    @conflicting_reservations = Reservation.conflict_validation(Reservation.where(hall_id: @reservation.hall_id), @reservation)
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :id, :title, :description, :number_of_people, :start_date, :end_date, :hall_id)
  end

  def premium_override
    if current_user.premium?
      session[:reservation_attributes] = @reservation.attributes
      redirect_to controller: 'reservations', action: 'confirm'
    else
      redirect_to reservations_path, alert: "Reservation conflict with
      #{
      @conflicting_reservations.each.map(&:title)
      }"
    end
  end


end
