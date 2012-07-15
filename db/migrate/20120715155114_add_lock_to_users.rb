class AddLockToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lock, :bool
  end
end
