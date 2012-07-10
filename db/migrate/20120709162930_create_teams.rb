class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :teamname
      t.integer :points
      t.integer :user_id

      t.timestamps
    end
  end
end
