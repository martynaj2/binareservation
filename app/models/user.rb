class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :surname, presence: true
  validates :name, :surname, length: { minimum: 2}

  has_many :reservations
  has_many :group_users
  has_many :group, through: :group_users

  def fullname
    "#{name} #{surname}"
  end


end
