class AddIndexToPlayerTeam < ActiveRecord::Migration
  def change
      add_index :team_players, [:player_id, :team_id],  :unique => true
  end
end
