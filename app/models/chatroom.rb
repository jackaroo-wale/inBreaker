class Chatroom < ApplicationRecord
  belongs_to :team
  has_many :messages, dependent: :destroy

  validates :name, presence: true
end
