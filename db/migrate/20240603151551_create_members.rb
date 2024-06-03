class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :weekly_points
      t.integer :total_points

      t.timestamps
    end
  end
end
