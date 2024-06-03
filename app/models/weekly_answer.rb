class WeeklyAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :weekly_question

  validates :content, presence: true
  validates :user_id, presence: true
  validates :weekly_question_id, presence: true
end
