class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :club
      t.string :position
      t.integer :goals
      t.integer :games
      t.integer :points

      t.timestamps
    end
  end
end
