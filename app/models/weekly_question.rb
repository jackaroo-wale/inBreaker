class WeeklyQuestion < ApplicationRecord
  belongs_to :team
  has_many :weekly_answers

  validates :content, presence: true
  validates :week_number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
