class CreateWeeklyQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :weekly_questions do |t|
      t.text :content
      t.integer :week_number

      t.timestamps
    end
  end
end
