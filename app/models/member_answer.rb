class MemberAnswer < ApplicationRecord
  belongs_to :member
  belongs_to :answerable, polymorphic: :true

  attribute :selected, :boolean
end
