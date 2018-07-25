class DateValidator < ActiveModel::Validator
  def validate(reservation)
    if reservation.start_date < Time.now
      reservation.errors[:base] << "start_date > Time.now"
    else
      if reservation.start_date >= reservation.end_date
        reservation.errors[:base] << "start_date > end_date"
      end
    end
  end
end

class Reservation < ActiveRecord::Base

  validates :title, :end_date, :start_date, :title, presence: true
  validates :title, length: { minimum: 5}
  validates_with DateValidator, if: Proc.new {|f| f.start_date && f.end_date}

  scope :ended, ->{where('end_date < ?', Time.now)}
  scope :not_ended, ->{where('start_date > ?', Time.now)}
  scope :during, ->{where('start_date < ?', Time.now)}
  scope :quarter, ->{where('start_date > ?', Time.now + 15.minutes && 'star_date <?', Time.now + 24.hours)}
  scope :twenty_four, ->{where('start_date > ?', Time.now - 24.hours)}

  belongs_to :user
  belongs_to :hall

  def as_json(options = {})
      {
        :id => self.id,
        :title => self.title,
        :start => self.start_date,
        :end => self.end_date,
       }
       end

  private


    def self.mail_helper(reservation, option)
      @users_id = reservation.invited_ids.split(',').map{ |elem| elem.to_i }
      @reservation = reservation
      @invitor = User.find(reservation.user_id)
      if @users_id.kind_of?(Array)
        @users_id.each do |m|
          @user = User.find(m)
          Reservation.mail_case_helper(@user, @reservation, @invitor, option)
        end
      elsif @users_id.kind_of?(Integer)
        @user = User.find(@users_id)
        Reservation.mail_case_helper(option)
      else
      end
    end

    def self.mail_case_helper(user, reservation, invitor, option)
      case option
      when 0
        ReservationMailer.invitation_mail(user, reservation, invitor).deliver_now
      when 1
        ReservationMailer.cancelation_mail(user, reservation, invitor).deliver_now
      when 2
        ReservationMailer.update_mail(user, reservation, invitor).deliver_now
      end
    end

  def self.conflict_validation(reservations, reservation)
    @conflicting_reservations = []
    unless reservations.empty?
      reservations.each do |r|
         if !((reservation.start_date >= r.end_date) || (reservation.end_date <= r.start_date))
          @conflicting_reservations.push(r)
        end
      end
    end
    @conflicting_reservations
  end

end
