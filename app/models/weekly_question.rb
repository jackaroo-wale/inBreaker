class WeeklyQuestion < ApplicationRecord
  has_many :weekly_answers
  has_many :wrong_answers, dependent: :destroy

  validates :content, presence: true
end
