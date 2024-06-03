class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :member, null: false, foreign_key: true
      t.references :weekly_question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
