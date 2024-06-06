class MoveWeekNumberFromWeeklyQuestionsToTeams < ActiveRecord::Migration[7.1]
  def change
    remove_column :weekly_questions, :week_number, :integer
    add_column :teams, :week_number, :integer
  end
end
