class AddWeeklyPointsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :weekly_points, :integer, :default => 0
  end
end
