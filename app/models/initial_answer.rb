class InitialAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :initial_question

  validates :content, presence: true
end
