class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_commit :remove_avatar!, on: :destroy
  before_destroy :destroy_reservations
  mount_uploader :avatar, AvatarUploader
  serialize :avatars, JSON

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :name, :surname, :email, presence: true
  validates :name, :surname, length: { minimum: 2, maximum: 15 }
  validates :avatar, file_size: { less_than: 1.megabytes }
  validates :email, length: { minimum: 2, maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :reservations
  has_many :group_users
  has_many :group, through: :group_users

  def fullname
    "#{name} #{surname}"
  end

  private

  def destroy_reservations
    reservations.destroy_all
  end
end
