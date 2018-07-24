class Hall < ActiveRecord::Base
  validates :title, :capacity, presence: true

  scope :small, -> {where('capacity <= 5')}
  scope :medium, -> {where('capacity > 5 AND capacity <= 10')}
  scope :large, -> {where('capacity > 10 AND capacity <= 20')}
  scope :extra_large, -> {where('capacity > 20')}


  has_many :reservations
end
