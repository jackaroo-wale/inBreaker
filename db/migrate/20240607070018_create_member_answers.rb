class CreateMemberAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :member_answers do |t|
      t.references :member, null: false, foreign_key: true
      t.references :answerable, polymorphic: true, null: false
      t.boolean :correct, default: false

      t.timestamps
    end
  end
end
