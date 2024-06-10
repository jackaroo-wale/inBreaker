class WeeklyAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :weekly_question
  has_many :members, as: :answerable
  attribute :selected, :boolean

  validates :content, presence: true

  def correct?(answer)
    answer == correct_answer
  end
end
