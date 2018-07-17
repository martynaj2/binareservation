class Hall < ActiveRecord::Base
  validates :title, presence: true
  validates :capacity, presence: true

  has_many :reservation_halls
  has_many :reservation, through: :reservation_halls
end
