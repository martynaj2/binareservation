class Hall < ActiveRecord::Base
  validates :title, presence: true
  validates :capacity, presence: true

  scope :large, -> {where('capacity > 10')}

  has_many :reservations
end
