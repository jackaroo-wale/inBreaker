class InitialAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :initial_question

  validates :content, presence: true
  validates :user_id, presence: true
  validates :initial_question_id, presence: true
end
