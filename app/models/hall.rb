class Hall < ActiveRecord::Base

  before_destroy :destroy_reservations
  validates :title, :capacity, presence: true
  validates :title, length: { minimum: 1, maximum: 15}

  scope :small, -> { where('capacity <= 5') }
  scope :medium, -> { where('capacity > 5 AND capacity <= 10') }
  scope :large, -> { where('capacity > 10 AND capacity <= 20') }
  scope :extra_large, -> { where('capacity > 20') }

  has_many :reservations

  private

  def destroy_reservations
    self.reservations.destroy_all
  end

end
