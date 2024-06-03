class Team < ApplicationRecord
  belongs_to :member
  belongs_to :weekly_question
end
