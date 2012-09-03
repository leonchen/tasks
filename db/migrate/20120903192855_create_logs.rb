class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |l|
      l.string :status
      l.text :value
      l.float :runtime
      l.timestamp :timestamp

      l.references :task
    end

    add_column :taskgroups, :logging, :boolean, :default => false, :null => false
    
    add_index(:logs, [:task_id, :timestamp])
  end
end
