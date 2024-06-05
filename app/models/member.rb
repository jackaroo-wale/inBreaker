class Member < ApplicationRecord
  belongs_to :user
  belongs_to :team

  # validates :weekly_points, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # validates :total_points, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
