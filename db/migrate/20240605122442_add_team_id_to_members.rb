class AddTeamIdToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :team_id, :integer
  end
end
