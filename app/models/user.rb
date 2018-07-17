class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :surname, presence: true
  validates :surname, :surname, length: { minimum: 2}

  def fullname
    "#{name} #{surname}"
  end


end
