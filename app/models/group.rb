class Group < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :users
  has_many :users, through: :group_users
end
