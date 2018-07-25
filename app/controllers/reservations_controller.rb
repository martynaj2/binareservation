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
  @users = User.where(id: @reservation.invited_ids.split(',').map{ |elem| elem.to_i })
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
      premium_override(true)
    end
  end

  def create
    inv_ids = (params[:reservation][:invited_ids])
    @reservation = current_user.reservations.build(reservation_params)
    reservations = Reservation.where(hall_id: @reservation.hall_id)
    @conflicting_reservations = Reservation.conflict_validation(reservations, @reservation)
    if @conflicting_reservations.empty?
       if @reservation.save
         @reservation.update(invited_ids: inv_ids)
         mail_helper(@reservation, 0)
         redirect_to reservations_path, notice: 'Reservation was created.'
       else
         redirect_to reservations_path, alert: "Something went wrong"
       end
     else
       premium_override(false)
     end
end

  def destroy
      @reservation = Reservation.find(params[:id])
      mail_helper(@reservation, 1)
      if @reservation.destroy
        redirect_to reservations_path, notice: "Reservation was deleted"
      else
        redirect_to reservations_path, alert: "Something went wrong"
      end
  end

  def overwrite
    @reservation = Reservation.new(session[:reservation_attributes])
    @conflicting_reservations = Reservation.conflict_validation(Reservation.where(hall_id: @reservation.hall_id), @reservation)
    @conflicting_reservations.each do |r|
      ReservationMailer.overwrite_mail(User.find(r.user_id), current_user, r).deliver_now
      r.destroy
    end
    if @reservation.save
      redirect_to reservations_path, notice: 'Reservation was created.'
    else
      redirect_to reservations_path, alert: "Something went wrong #{@reservation.errors.full_messages}"
    end
    session.delete(:reservation_attributes)
  end

  def edit_overwrite
    @reservation = Reservation.find(session[:reservation_id])
    current_reservation = current_user.reservations.build(session[:reservation_params])
    reservations = Reservation.where(hall_id: @reservation.hall_id).where.not(id: @reservation.id)
    @conflicting_reservations = Reservation.conflict_validation(reservations, current_reservation)
    @conflicting_reservations.each do |r|
      ReservationMailer.overwrite_mail(User.find(r.user_id), current_user, r).deliver_now
      r.destroy
    end
    if @reservation.update(session[:reservation_params])
      redirect_to reservations_path, notice: 'Reservation was updated.'
    else
      redirect_to reservations_path, alert: "Something went wrong #{@reservation.errors.full_messages}"
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

  def mail_helper(reservation, option)
    @users_id = reservation.invited_ids.split(',').map{ |elem| elem.to_i }
    @reservation = reservation
    @invitor = User.find(reservation.user_id)
    if @users_id.kind_of?(Array)
      @users_id.each do |m|
        @user = User.find(m)
        case option
        when 0
          ReservationMailer.invitation_mail(@user, @reservation, @invitor).deliver_now
        when 1
          ReservationMailer.cancelation_mail(@user, @reservation, @invitor).deliver_now
        end
      end
    elsif @users_id.kind_of?(Integer)
      @user = User.find(@users_id)
      case option
      when 0
        ReservationMailer.invitation_mail(@user, @reservation, @invitor).deliver_now
      when 1
        ReservationMailer.cancelation_mail(@user, @reservation, @invitor).deliver_now
      end
    else
    end
  end

  def reservation_params
    params.require(:reservation).permit(
      :id, :title, :start_date, :end_date, :hall_id, :invited_ids)
  end

  def premium_override(edit)
    if current_user.premium?
      if edit
        session[:reservation_id] = @reservation.id
        session[:reservation_params] = reservation_params
        redirect_to controller: 'reservations', action: 'confirm_update'
      else
        session[:reservation_attributes] = @reservation.attributes
        redirect_to controller: 'reservations', action: 'confirm'
      end
    else
      redirect_to reservations_path, alert: "Reservation conflict with
      #{
      @conflicting_reservations.each.map(&:title)
      }"
    end
  end

end
