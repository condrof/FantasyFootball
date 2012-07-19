class AddLockToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :lock, :bool
  end
end
