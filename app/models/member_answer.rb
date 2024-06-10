class MemberAnswer < ApplicationRecord
  belongs_to :member
  belongs_to :weekly_answer, optional: true
  belongs_to :initial_answer, optional: true

  after_save :update_member_score, if: :correct?

  validates :member_id, presence: true
  validate :answer_presence
  validates :correct, inclusion: { in: [true, false] }

  private

  def update_member_score
    member.increment!(:score)
  end

  def answer_presence
    if weekly_answer_id.nil? && initial_answer_id.nil?
      errors.add(:base, "Either weekly_answer or initial_answer must be present")
    end
  end
end
