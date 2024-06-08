class Member < ApplicationRecord
  belongs_to :user
  belongs_to :team

  has_many :member_answers
  has_many :weekly_answers, through: :member_answers, source: :answerable, source_type: 'WeeklyAnswer'

  def points
    member_answers.where(correct: true).count
  end
end
