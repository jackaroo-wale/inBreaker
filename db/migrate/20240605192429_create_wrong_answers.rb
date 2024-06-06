class CreateWrongAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :wrong_answers do |t|
      t.text :content
      t.references :weekly_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
