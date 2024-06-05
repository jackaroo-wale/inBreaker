class Team < ApplicationRecord
  has_many :members
  has_many :users, through: :members
<<<<<<< HEAD
  has_many :weekly_questions
  accepts_nested_attributes_for :members
=======
>>>>>>> master

  validates :name, presence: true, uniqueness: true
end
