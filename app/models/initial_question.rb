class InitialQuestion < ApplicationRecord
  has_many :initial_answers

  validates :content, presence: true
end
