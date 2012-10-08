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

ActiveRecord::Schema.define(:version => 20121008082623) do

  create_table "admin_todo_lists", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "starred",      :default => false
    t.datetime "due_date"
    t.datetime "completed_at"
    t.datetime "deleted_at"
    t.integer  "todo_tag_id"
    t.integer  "user_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "admin_todo_lists", ["name"], :name => "index_admin_todo_lists_on_name", :unique => true
  add_index "admin_todo_lists", ["starred"], :name => "index_admin_todo_lists_on_starred"
  add_index "admin_todo_lists", ["todo_tag_id"], :name => "index_admin_todo_lists_on_todo_tag_id"
  add_index "admin_todo_lists", ["user_id"], :name => "index_admin_todo_lists_on_user_id"

  create_table "admin_todo_tags", :force => true do |t|
    t.string   "name"
    t.boolean  "static",     :default => false
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "admin_todo_tags", ["name"], :name => "index_admin_todo_tags_on_name", :unique => true
  add_index "admin_todo_tags", ["static"], :name => "index_admin_todo_tags_on_static"
  add_index "admin_todo_tags", ["user_id"], :name => "index_admin_todo_tags_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name",                   :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
