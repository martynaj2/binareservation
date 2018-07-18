class Reservation < ActiveRecord::Base

  validates :title, presence: true, length: { minimum: 5}
  validates :description, presence: true, length: { minimum: 10 }
  validates :number_of_people, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  # validates :inviter, presence: true

  belongs_to :user
  has_many :halls
  has_many :halls, through: :reservation_halls

end
