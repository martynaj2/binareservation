class Group < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
   has_many :users
   has_many :users, through: :group_users
end
