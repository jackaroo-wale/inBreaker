class CreateWeeklyAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :weekly_answers do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :weekly_question, null: false, foreign_key: true
      t.string :wrong_answers, default: ""

      t.timestamps
    end
  end
end
