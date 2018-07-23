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

  validates :title, presence: true, length: { minimum: 5}
  validates :number_of_people, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_with DateValidator, if: Proc.new {|f| f.start_date && f.end_date}

  scope :ended, ->{where('end_date < ?', Time.now)}
  scope :during, ->{where('start_date < ?', Time.now)}
  scope :quarter, ->{where('start_date > ?', Time.now + 15.minutes && 'star_date <?', Time.now + 24.hours)}
  scope :twenty_four, ->{where('start_date > ?', Time.now - 24.hours)}

  belongs_to :user
  belongs_to :hall

end
