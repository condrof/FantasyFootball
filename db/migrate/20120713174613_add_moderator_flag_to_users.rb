class AddModeratorFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :moderator, :bool
  end
end
