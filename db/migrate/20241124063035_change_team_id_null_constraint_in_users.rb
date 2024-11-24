class ChangeTeamIdNullConstraintInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :team_id, true
  end
end
