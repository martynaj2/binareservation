class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = Reservation.not_ended
  end

  def user_index
    @reservations = current_user.reservations
  end

  def show
    @reservation = Reservation.find(params[:id])
    @users = User.where(id: @reservation.invited_ids.split(',').map(&:to_i)) unless @reservation.invited_ids.nil?
  end

  def new
    @reservation = Reservation.new(hall_id: params[:hall_id], start_date: params[:start_date], end_date: params[:end_date])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    inv_ids = (params[:reservation][:invited_ids])
    @reservation = Reservation.find(params[:id])
    current_reservation = current_user.reservations.build(reservation_params)
    reservations = Reservation.where(hall_id: @reservation.hall_id).where.not(id: params[:id])
    @conflicting_reservations = Reservation.conflict_validation(reservations, current_reservation)
    hash = { invited_ids: inv_ids }
    reservation_params.merge(hash)
    if @conflicting_reservations.empty?
      if @reservation.update(reservation_params)
        Reservation.mail_helper(@reservation, 2)
        Reservation.delete_notification(@reservation)
        Reservation.notify_mail_helper(@reservation)
        redirect_to reservations_path, notice: 'Reservation Updated'
      else
        render :edit
      end
    else
      premium_override(true)
    end
  end

  def create
    @reservation = current_user.reservations.build(reservation_params.merge(invited_ids: params[:reservation][:invited_ids]))
    reservations = Reservation.where(hall_id: @reservation.hall_id)
    @conflicting_reservations = Reservation.conflict_validation(reservations, @reservation)
    if @conflicting_reservations.empty?
      if @reservation.save
        Reservation.mail_helper(@reservation, 0)
        Reservation.notify_mail_helper(@reservation)
        redirect_to reservations_path, notice: 'Reservation was created.'
      else
<<<<<<< HEAD
        redirect_to reservations_path, alert: "Something went wrong #{ @reservation.errors.full_messages }"
=======
        redirect_to reservations_path, alert: "Something went wrong #{@reservation.errors.full_messages}"
>>>>>>> f9704f9fb7f0f94105a56a91f8850ec9ce67932b
      end
    else
      premium_override(false)
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      Reservation.mail_helper(@reservation, 1)
      Reservation.delete_notification(@reservation)
      redirect_to reservations_path, notice: 'Reservation was deleted'
    else
      redirect_to reservations_path, alert: 'Something went wrong'
    end
  end

  def overwrite
    @reservation = Reservation.new(session[:reservation_attributes])
    @conflicting_reservations = Reservation.conflict_validation(Reservation.where(hall_id: @reservation.hall_id), @reservation)
    if @reservation.save
      @conflicting_reservations.each do |r|
        ReservationMailer.overwrite_mail(User.find(r.user_id), current_user, r).deliver_now
        r.destroy
        Reservation.mail_helper(r, 1)
        Reservation.delete_notification(r)
      end
      Reservation.mail_helper(@reservation, 0)
      Reservation.notify_mail_helper(@reservation)
      redirect_to reservations_path, notice: 'Reservation was created.'
    else
      redirect_to reservations_path, alert: "Something went wrong. #{@reservation.errors.full_messages}"
    end
    session.delete(:reservation_attributes)
  end

  def edit_overwrite
    @reservation = Reservation.find(session[:reservation_id])
    current_reservation = current_user.reservations.build(session[:reservation_params])
    reservations = Reservation.where(hall_id: @reservation.hall_id).where.not(id: @reservation.id)
    @conflicting_reservations = Reservation.conflict_validation(reservations, current_reservation)
    if @reservation.update(session[:reservation_params])
      @conflicting_reservations.each do |r|
        ReservationMailer.overwrite_mail(User.find(r.user_id), current_user, r).deliver_now
        r.destroy
        Reservation.mail_helper(r, 1)
        Reservation.delete_notification(r)
      end
      Reservation.mail_helper(@reservation, 2)
      Reservation.notify_mail_helper(@reservation)
      redirect_to reservations_path, notice: 'Reservation was updated.'
    else
      redirect_to reservations_path, alert: "Something went wrong. #{@reservation.errors.full_messages}"
    end
    session.delete(:reservation_params)
  end

  def confirm
    @reservation = Reservation.new(session[:reservation_attributes])
    @conflicting_reservations = Reservation.conflict_validation(Reservation.where(hall_id: @reservation.hall_id), @reservation)
  end

  def edit_confirm
    @reservation = Reservation.find(session[:reservation_id])
    current_reservation = current_user.reservations.build(session[:reservation_params])
    reservations = Reservation.where(hall_id: @reservation.hall_id).where.not(id: @reservation.id)
    @conflicting_reservations = Reservation.conflict_validation(reservations, current_reservation)
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :id, :title, :start_date, :end_date, :hall_id, :invited_ids
    )
  end

  def premium_override(edit)
    if current_user.premium?
      if edit
        session[:reservation_id] = @reservation.id
        session[:reservation_params] = reservation_params
        redirect_to controller: 'reservations', action: 'edit_confirm'
      else
        session[:reservation_attributes] = @reservation.attributes
        redirect_to controller: 'reservations', action: 'confirm'
      end
    else
      redirect_to reservations_path, alert: "Reservation conflict with
      #{@conflicting_reservations.each.map(&:title)}"
    end
  end
end
