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

  scope :ended, -> { where('end_date < ?', Time.zone.now) }
  scope :not_ended, -> { where('start_date > ?', Time.zone.now) }
  scope :during, -> { where('start_date < ?', Time.zone.now) }
  scope :quarter, -> { where('start_date < ?', Time.zone.now + 15.minutes) }
  scope :twenty_four, -> { where('start_date > ?', Time.zone.now - 24.hours) }

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
    unless reservation.invited_ids.nil?
      @users_id = reservation.invited_ids.split(',').map(&:to_i)
      @reservation = reservation
      @invitor = User.find(reservation.user_id)
      if @users_id.count >= 1
        @users_id.each do |m|
          @user = User.find(m)
          Reservation.mail_case_helper(@user, @reservation, @invitor, option) unless @user.vacation
        end
      end
    end
    Reservation.mail_case_helper(@invitor, @reservation, @invitor, option) if [3, 4].include?(option)
  end

  def self.delete_notification(reservation)
    queue = Sidekiq::ScheduledSet.new
    queue.each do |job|
      job.delete if reservation.id == job.args[0]['arguments'][0]['_aj_globalid'][-2, 2].to_i
    end
  end

  def self.notify_mail_helper(reservation)
    if reservation.start_date > Time.zone.now + 15.minutes
      NotifyQuarter.set(
        wait_until: reservation.start_date - 15.minutes
      ).perform_later(reservation)
    end
    return if reservation.start_date < Time.zone.now + 24.hours
    NotifyTwentyFour.set(
      wait_until: reservation.start_date - 24.hours
    ).perform_later(reservation)
  end

  def self.mail_case_helper(user, reservation, invitor, option)
    case option
    when 0
      ReservationMailer.invitation_mail(user, reservation, invitor).deliver_now
    when 1
      ReservationMailer.cancelation_mail(user, reservation, invitor).deliver_now
    when 2
      ReservationMailer.update_mail(user, reservation, invitor).deliver_now
    when 3
      ReservationMailer.quarter_notification_mail(user, reservation, invitor).deliver
    when 4
      ReservationMailer.twenty_four_notification_mail(user, reservation, invitor).deliver
    end
  end
end
