class Hall < ActiveRecord::Base
  validates :title, presence: true
  validates :capacity, presence: true
end
