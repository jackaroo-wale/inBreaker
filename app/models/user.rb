class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :initial_answers
  has_many :weekly_answers
  has_many :members, dependent: :destroy
  has_many :teams, through: :members
  has_one_attached :profile_image
  validates :username, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 200 }
  before_destroy :destroy_associated_records

  has_many :sent_conversations, class_name: 'Conversation', foreign_key: :sender_id
  has_many :received_conversations, class_name: 'Conversation', foreign_key: :receiver_id
  has_many :private_messages

  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id', dependent: :destroy

  validates :email, presence: true, uniqueness: true

  private

  def destroy_associated_records
    self.initial_answers.destroy_all
    self.weekly_answers.destroy_all
    self.members.destroy_all
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
