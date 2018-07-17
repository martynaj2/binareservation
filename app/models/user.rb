class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

<<<<<<< HEAD
 def fullname
   "#{name} #{surname}"
 end
=======
  validates :name, presence: true, length: { minimum: 3 }
  validates :surname, presence: true, length: { minimum: 2}
  validates :email, presence: true
>>>>>>> 5c0ba419f1af9c65bb3ab89ed2419d45ae0bdbf0

end
