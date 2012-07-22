class AddAttributesToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :value, :integer, :default => 0
    add_column :players, :part_appearances, :integer, :default => 0
    add_column :players, :yellows, :integer, :default => 0
    add_column :players, :reds, :integer, :default => 0
    add_column :players, :clean_sheets, :integer, :default => 0
    add_column :players, :part_clean_sheets, :integer, :default => 0
    add_column :players, :key_contributions, :integer, :default => 0
    
  end
end
 