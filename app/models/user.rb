class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_commit :remove_avatar!, on: :destroy

  mount_uploader :avatar, AvatarUploader
  serialize :avatars, JSON

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :surname, :email, presence: true
  validates :name, :surname, length: { minimum: 2}
  validates :avatar, file_size: { less_than: 1.megabytes }

  has_many :reservations
  has_many :group_users
  has_many :group, through: :group_users

  def fullname
    "#{name} #{surname}"
  end


end
