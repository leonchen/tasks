class CreateTasks < ActiveRecord::Migration
  def change
    create_table :taskgroups do |tg|
      tg.string :name, :null => false
      tg.boolean :enabled, :default => true
      tg.text :settings
      tg.integer :tasks_count, :default => 0
      tg.timestamps
    end

    create_table :resources do |r|
      r.string :name, :null => false 
      r.boolean  :enabled, :default => true
      r.integer :tasks_count, :default => 0
      r.timestamps
    end

    create_table :tasks do |t|
      t.string :name, :null => false
      t.boolean :enabled, :default => true
      t.text :resource_data

      t.references :resource
      t.references :taskgroup

      t.timestamps
    end

    add_index(:taskgroups, :name, :unique => true)
    add_index(:resources, :name, :unique => true)
    add_index(:tasks, :name, :unique => true)
    add_index(:tasks, :resource_id)
    add_index(:tasks, :taskgroup_id)
  end
end
