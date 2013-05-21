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

ActiveRecord::Schema.define(:version => 20130521205421) do

  create_table "customers", :force => true do |t|
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
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
  end

  create_table "delivery_slots", :force => true do |t|
    t.string   "day"
    t.time     "start_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "ingredients", :force => true do |t|
    t.integer  "raw_id"
    t.integer  "prepared_id"
    t.decimal  "quantity",    :precision => 8, :scale => 3
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "image_url"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.integer  "user_id"
    t.integer  "orders_count",                               :default => 0
    t.string   "item_type"
    t.string   "spec_number"
    t.string   "name"
    t.text     "description"
    t.string   "pricing_unit"
    t.integer  "vendor_id"
    t.decimal  "price",        :precision => 8, :scale => 2, :default => 0.0
  end

  create_table "line_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "delivery_slot_id"
    t.integer  "quantity"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.integer  "item_id"
    t.boolean  "delivered"
    t.decimal  "price",            :precision => 8, :scale => 2
  end

  create_table "orders", :force => true do |t|
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "user_id"
    t.datetime "start_date"
    t.integer  "customer_id"
    t.integer  "item_id"
    t.string   "status"
    t.decimal  "total",         :precision => 8, :scale => 2
    t.date     "complete_date"
  end

  create_table "payment_dues", :force => true do |t|
    t.integer  "amount"
    t.boolean  "paid"
    t.integer  "order_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.datetime "bill_cycle_start"
    t.datetime "bill_cycle_end"
    t.datetime "due_date"
  end

  create_table "payment_recvds", :force => true do |t|
    t.integer  "payment_amount"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "order_id"
  end

  create_table "sites", :force => true do |t|
    t.string   "company_name"
    t.string   "logo"
    t.string   "headline"
    t.text     "description"
    t.string   "website_url"
    t.string   "facebook"
    t.string   "twitter"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
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
  end

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "contact_name"
    t.text     "address"
    t.string   "phone"
    t.string   "email"
    t.text     "notes"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
