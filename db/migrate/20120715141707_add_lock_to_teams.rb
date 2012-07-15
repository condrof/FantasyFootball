class AddLockToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :lock, :bool
  end
end
