class Hall < ActiveRecord::Base

  validates :title, :capacity, presence: true
  validates :title, length: { minimum: 3 }

  scope :large, -> {where('capacity > 10')}

  has_many :reservations
end
