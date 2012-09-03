class AddIsRunningFieldToTaskgroupsAndTasks < ActiveRecord::Migration
  def change
    add_column :taskgroups, :is_running, :boolean, :default => false, :null => false
    add_column :tasks, :is_running, :boolean, :default => false, :null => false
    add_column :tasks, :last_runtime, :float
    add_column :tasks, :last_status, :string
    add_column :tasks, :last_value, :text

    add_index(:taskgroups, :is_running)
    add_index(:tasks, :is_running)
    add_index(:tasks, :last_runtime)
    add_index(:tasks, :last_status)
  end
end
