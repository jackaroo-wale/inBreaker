class RemoveWrongAnswersFromWeeklyQuestions < ActiveRecord::Migration[7.1]
  def change
    remove_column :weekly_questions, :wrong_answers
  end
end
