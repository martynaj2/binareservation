class Hall < ActiveRecord::Base
  validates :title, :capacity, :hall_color, presence: true
  validates :title, length: { minimum: 1, maximum: 10 }

  scope :small, -> { where('capacity <= 5') }
  scope :medium, -> { where('capacity > 5 AND capacity <= 10') }
  scope :large, -> { where('capacity > 10 AND capacity <= 20') }
  scope :extra_large, -> { where('capacity > 20') }

  has_many :reservations, dependent: :destroy
end
