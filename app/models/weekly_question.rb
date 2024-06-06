class WeeklyQuestion < ApplicationRecord
  has_many :weekly_answers
  has_many :wrong_answers, dependent: :destroy

  validates :content, presence: true
  validates :correct_answer, presence: true
  validates :week_number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def correct_answer?(user_answer)
    user_answer.strip.downcase == correct_answer.strip.downcase
  end
end
