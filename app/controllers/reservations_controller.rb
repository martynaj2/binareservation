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
    date_validation('update')
    if @conflict.empty?
       if @reservation.update(reservation_params)
         redirect_to reservations_path, notice: 'Reservation Updated'
       else
         render :edit
       end
    else
    redirect_to reservations_path, alert: "Reservation conflict with
      #{
      @conflict.each.map(&:title)
      }"
    end
  end

  def create
    date_validation('create')
    if @conflict.empty?
       if @reservation.save
         redirect_to reservations_path, notice: 'Reservation was created.'
       else
         redirect_to reservations_path, alert: "Something went wrong #{@reservation.errors.full_messages}"
       end
    else
      redirect_to reservations_path, alert: "Reservation conflict with
      #{
      @conflict.each.map(&:title)
      }"
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
  end

  def date_validation(condition)
    @conflict = []
    @reservation = current_user.reservations.build(reservation_params)

    if condition == 'create'
      @reservations = Reservation.where(hall_id: @reservation.hall_id)
    elsif condition=='update'
      @reservations = Reservation.where(hall_id: @reservation.hall_id).where.not(id: params[:id])
    else
      return false
    end

    if @reservations.empty?
      @conflict = []
    else
      @reservations.each do |r|
         if !((@reservation.start_date >= r.end_date) || (@reservation.end_date <= r.start_date))
          @conflict.push(r)
        end
      end
    end
  end

end
