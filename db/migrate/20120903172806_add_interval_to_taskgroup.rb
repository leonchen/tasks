class AddIntervalToTaskgroup < ActiveRecord::Migration
  def change
    add_column :taskgroups, :interval, :integer, :default => 86400, :null => false 
    add_column :tasks, :last_run, :timestamp, :default => 0, :null => false

    add_index(:tasks, :last_run)
  end
end
