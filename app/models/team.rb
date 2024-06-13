class Team < ApplicationRecord
  has_many :members
  has_many :users, through: :members
  has_many :weekly_questions
  has_one_attached :team_image

  has_many :messages, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_many :conversations
end
