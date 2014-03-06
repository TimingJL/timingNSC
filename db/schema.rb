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

ActiveRecord::Schema.define(:version => 20140107163308) do

  create_table "article_entries", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "article_id"
    t.integer  "catagory_id"
    t.string   "catagory_type"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.datetime "authorize_at"
    t.text     "content"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "authorize_at_string"
    t.string   "source"
    t.integer  "score"
    t.integer  "label"
    t.text     "url"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "export_log_keywords", :force => true do |t|
    t.string   "keyword"
    t.string   "source"
    t.string   "name"
    t.string   "email"
    t.string   "request_type"
    t.string   "category_type"
    t.string   "file_path"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "export_logs", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "request_type"
    t.string   "category_type"
    t.string   "category_id"
    t.string   "file_path"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "google_dates", :force => true do |t|
    t.date     "indexed_at"
    t.string   "lock"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "keywords", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "lock"
  end

  create_table "kmw", :force => true do |t|
    t.string   "name"
    t.string   "tag"
    t.boolean  "lock"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kmw_prelinks", :force => true do |t|
    t.text     "url"
    t.boolean  "success"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "macrolevels", :force => true do |t|
    t.string   "name"
    t.string   "tag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "lock"
  end

  create_table "mobile_devices", :force => true do |t|
    t.string   "email"
    t.string   "registration_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "task_logs", :force => true do |t|
    t.string   "duration"
    t.string   "catagory_type"
    t.integer  "catagory_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
