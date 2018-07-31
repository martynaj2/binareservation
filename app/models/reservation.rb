class DateValidator < ActiveModel::Validator
  def validate(reservation)
    if reservation.start_date < Time.zone.now
      reservation.errors[:base] << 'start_date > Time.zone.now'
    elsif reservation.start_date >= reservation.end_date
    end
  end
end

class Reservation < ActiveRecord::Base

  validates :title, :end_date, :start_date, :title, presence: true
  validates :title, length: { minimum: 2, maximum: 30 }
  validates_with DateValidator, if: proc { |f| f.start_date && f.end_date }

  scope :ended, ->{where('end_date < ?', Time.now)}
  scope :not_ended, ->{where('start_date > ?', Time.now)}
  scope :during, ->{where('start_date < ?', Time.now)}
  scope :quarter, ->{where('start_date < ?', Time.now + 15.minutes)}
  scope :twenty_four, ->{where('start_date > ?', Time.now - 24.hours)}

  belongs_to :user
  belongs_to :hall

  def as_json(_options = {})
    {
      id: id,
      title: title,
      start: start_date,
      end: end_date,
      description: self.Hall.find(hall_id).title
    }
  end

  def self.delete_ended_reservations
    Reservation.ended.destroy_all
  end

  def self.conflict_validation(reservations, reservation)
    @conflicting_reservations = []
    unless reservations.empty?
      reservations.each do |r|
        unless (reservation.start_date >= r.end_date) || (reservation.end_date <= r.start_date)
          @conflicting_reservations.push(r)
       end
      end
    end
    @conflicting_reservations
  end

  def self.mail_helper(reservation, option)
    unless (reservation.invited_ids == nil)
      @users_id = reservation.invited_ids.split(',').map{ |elem| elem.to_i }
      @reservation = reservation
      @invitor = User.find(reservation.user_id)
        @users_id.each do |m|
          @user = User.find(m)
          unless @user.vacation
            Reservation.mail_case_helper(@user, @reservation, @invitor, option)
          end
        end
    end
  end

  private

  def self.mail_case_helper(user, reservation, invitor, option)
    case option
    when 0
      ReservationMailer.invitation_mail(user, reservation, invitor).deliver_later
    when 1
      ReservationMailer.cancelation_mail(user, reservation, invitor).deliver_later
    when 2
      ReservationMailer.update_mail(user, reservation, invitor).deliver_later
    when 3
      ReservationMailer.quarter_notification_mail(user, reservation, invitor).deliver
    end
  end

end
