class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :initial_answers
  has_many :weekly_answers
  has_many :members
  has_many :teams, through: :members

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
