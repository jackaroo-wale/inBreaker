class AddDefaultToWeekNumber < ActiveRecord::Migration[7.1]
  def change
    change_column_default :teams, :week_number, 0
  end
end
