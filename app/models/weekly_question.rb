class WeeklyQuestion < ApplicationRecord
  has_many :weekly_answers
  has_many :wrong_answers, dependent: :destroy

  validates :content, presence: true

  def correct_answer?(user_answer)
    user_answer.strip.downcase == correct_answer.strip.downcase
  end
end
