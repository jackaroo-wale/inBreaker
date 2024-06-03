class Team < ApplicationRecord
  belongs_to :member
  belongs_to :weekly_question
  has_many :members
  has_many :users, through: :members
  has_many :weekly_questions

  validates :name, presence: true, uniqueness: true
end
