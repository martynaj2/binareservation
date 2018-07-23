class Hall < ActiveRecord::Base
  validates :title, :capacity, presence: true

  scope :large, -> {where('capacity > 10')}

  has_many :reservations
end
