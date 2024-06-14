class Conversation < ApplicationRecord
  belongs_to :team
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :receiver, class_name: 'User', foreign_key: :receiver_id
  has_many :private_messages, dependent: :destroy

  validates :sender_id, uniqueness: { scope: [:receiver_id, :team_id] }
end
