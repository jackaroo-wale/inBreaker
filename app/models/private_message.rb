class PrivateMessage < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :content, presence: true
end
