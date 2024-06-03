class InitialAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :initial_question
end
