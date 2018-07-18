class Hall < ActiveRecord::Base
  validates :title, presence: true
  validates :capacity, presence: true

  has_many :reservations
end
