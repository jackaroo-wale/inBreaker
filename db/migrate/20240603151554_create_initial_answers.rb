class CreateInitialAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :initial_answers do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :initial_question, null: false, foreign_key: true
      t.string :wrong_answers, default: ""

      t.timestamps
    end
  end
end
