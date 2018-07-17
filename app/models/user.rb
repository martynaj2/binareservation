class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { minimum: 3 }
  validates :surname, presence: true, length: { minimum: 2}
  validates :email, presence: true

  def fullname
    "#{name} #{surname}"
  end

end
