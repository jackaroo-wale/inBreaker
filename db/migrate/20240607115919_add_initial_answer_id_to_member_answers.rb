class AddInitialAnswerIdToMemberAnswers < ActiveRecord::Migration[7.1]
  def change
    add_reference :member_answers, :weekly_answer, foreign_key: true
    change_column_null :member_answers, :weekly_answer_id, true
  end
end
