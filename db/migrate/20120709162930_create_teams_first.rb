class CreateTeamsFirst < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :teamname
      t.integer :points

      t.timestamps
    end
  end
end
