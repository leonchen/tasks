class InitializeTables < ActiveRecord::Migration
  def change
    create_table :taskgroups do |tg|
      tg.string :name, :null => false
      tg.boolean :enabled, :default => true
      tg.text :resource_settings
      tg.integer :tasks_count, :default => 0
      tg.integer :interval, :default => 86400, :null => false
      tg.boolean :is_running, :default => false, :null => false
      tg.boolean :logging, :default => false, :null => false
      tg.timestamps

      tg.references :resource
    end

    create_table :resources do |r|
      r.string :name, :null => false 
      r.boolean  :enabled, :default => true
      r.timestamps
    end

    create_table :tasks do |t|
      t.string :name, :null => false
      t.boolean :enabled, :default => true
      t.text :resource_data
      t.timestamp :last_run, :default => 0, :null => false
      t.boolean :is_running, :default => false, :null => false
      t.float :last_runtime
      t.string :last_status
      t.text :last_value

      t.references :taskgroup

      t.timestamps
    end

    create_table :logs do |l|
      l.string :status
      l.text :value
      l.float :runtime
      l.timestamp :timestamp

      l.references :task
    end

    add_index(:taskgroups, :name, :unique => true)
    add_index(:resources, :name, :unique => true)
    add_index(:tasks, :name, :unique => true)
    add_index(:taskgroups, :is_running)
    add_index(:tasks, :is_running)
    add_index(:tasks, :taskgroup_id)
    add_index(:tasks, :last_run)
    add_index(:tasks, :last_runtime)
    add_index(:tasks, :last_status)
    add_index(:logs, [:task_id, :timestamp])
  end

end
