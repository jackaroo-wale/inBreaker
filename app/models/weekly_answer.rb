class WeeklyAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :weekly_question

  validates :content, presence: true
  attribute :correct_answer_index, :integer
end
