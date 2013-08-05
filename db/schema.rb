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

ActiveRecord::Schema.define(:version => 20130805163310) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
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

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "customers", :force => true do |t|
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "address_one"
    t.string   "address_two"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "company_name"
    t.string   "poc_name"
    t.integer  "user_id"
    t.text     "note"
    t.string   "term"
    t.string   "archive_number"
    t.datetime "archived_at"
  end

  create_table "customers_delivery_slots", :force => true do |t|
    t.integer "customer_id"
    t.integer "delivery_slot_id"
    t.integer "customers_id"
    t.integer "delivery_slots_id"
  end

  create_table "delivery_dates", :force => true do |t|
    t.datetime "scheduled_for"
    t.integer  "weekly_schedule_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "delivery_slot_id"
  end

  create_table "delivery_details", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "weekly_schedule_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "delivery_date_id"
    t.integer  "invoice_id"
    t.string   "archive_number"
    t.datetime "archived_at"
  end

  create_table "delivery_slots", :force => true do |t|
    t.string   "day"
    t.time     "start_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "user_id"
    t.integer  "weekly_schedule_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "memo"
    t.string   "archive_number"
    t.datetime "archived_at"
  end

  create_table "items", :force => true do |t|
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "price",          :precision => 8, :scale => 2, :default => 0.0
    t.string   "archive_number"
    t.datetime "archived_at"
  end

  create_table "order_quantities", :force => true do |t|
    t.integer  "item_id"
    t.integer  "quantity",           :default => 0
    t.integer  "delivery_detail_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "qty_delivered",      :default => 0
    t.integer  "qty_returned",       :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "name"
    t.string   "account_type"
    t.string   "phone_number"
    t.string   "tax_id"
    t.string   "dob"
    t.string   "city"
    t.string   "postal_code"
    t.string   "street_address"
    t.string   "uri"
    t.string   "bank_uri"
    t.string   "company_name"
    t.string   "state"
    t.string   "qb_token"
    t.string   "qb_secret"
    t.string   "qb_realm_id"
    t.boolean  "quickbooks_desktop"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  create_table "weekly_schedules", :force => true do |t|
    t.integer  "user_id"
    t.datetime "week_start"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
