class AddTeamRefToWeeklyQuestions < ActiveRecord::Migration[7.1]
  def change
    add_reference :weekly_questions, :team, null: false, foreign_key: true
  end
end
