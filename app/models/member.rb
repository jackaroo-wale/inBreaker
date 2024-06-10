class Member < ApplicationRecord
  belongs_to :user
  belongs_to :team

  has_many :member_answers

  def correct_answers_count
    member_answers.where(correct: true).count
  end
end
