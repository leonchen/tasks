# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120904090423) do

  create_table "logs", :force => true do |t|
    t.string   "status"
    t.text     "value"
    t.float    "runtime"
    t.datetime "timestamp"
    t.integer  "task_id"
  end

  add_index "logs", ["task_id", "timestamp"], :name => "index_logs_on_task_id_and_timestamp"

  create_table "resources", :force => true do |t|
    t.string   "name",                         :null => false
    t.boolean  "enabled",    :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "resources", ["name"], :name => "index_resources_on_name", :unique => true

  create_table "taskgroups", :force => true do |t|
    t.string   "name",                                 :null => false
    t.boolean  "enabled",           :default => true
    t.text     "resource_settings"
    t.integer  "tasks_count",       :default => 0
    t.integer  "interval",          :default => 86400, :null => false
    t.boolean  "is_running",        :default => false, :null => false
    t.boolean  "logging",           :default => false, :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "resource_id"
  end

  add_index "taskgroups", ["is_running"], :name => "index_taskgroups_on_is_running"
  add_index "taskgroups", ["name"], :name => "index_taskgroups_on_name", :unique => true

  create_table "tasks", :force => true do |t|
    t.string   "name",                             :null => false
    t.boolean  "enabled",       :default => true
    t.text     "resource_data"
    t.datetime "last_run",                         :null => false
    t.boolean  "is_running",    :default => false, :null => false
    t.float    "last_runtime"
    t.string   "last_status"
    t.text     "last_value"
    t.integer  "taskgroup_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "tasks", ["is_running"], :name => "index_tasks_on_is_running"
  add_index "tasks", ["last_run"], :name => "index_tasks_on_last_run"
  add_index "tasks", ["last_runtime"], :name => "index_tasks_on_last_runtime"
  add_index "tasks", ["last_status"], :name => "index_tasks_on_last_status"
  add_index "tasks", ["name"], :name => "index_tasks_on_name", :unique => true
  add_index "tasks", ["taskgroup_id"], :name => "index_tasks_on_taskgroup_id"

end
