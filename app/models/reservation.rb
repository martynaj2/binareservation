class DateValidator < ActiveModel::Validator
  def validate(reservation)
    if reservation.start_date >= reservation.end_date
      reservation.errors[:base] << "start_date > end_date"
    end
  end
end

class Reservation < ActiveRecord::Base

  validates :title, presence: true, length: { minimum: 5}
  validates :description, presence: true, length: { minimum: 10 }
  validates :number_of_people, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_with DateValidator

  belongs_to :user
  belongs_to :hall

end
