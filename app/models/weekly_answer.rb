class WeeklyAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :weekly_question
end
