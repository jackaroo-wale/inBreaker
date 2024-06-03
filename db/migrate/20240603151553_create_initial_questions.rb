class CreateInitialQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :initial_questions do |t|
      t.text :content

      t.timestamps
    end
  end
end
