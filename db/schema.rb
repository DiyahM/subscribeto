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

ActiveRecord::Schema.define(:version => 20130421184854) do

  create_table "customers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "order_id"
  end

  create_table "orders", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "plan_id"
  end

  create_table "plans", :force => true do |t|
    t.string   "plan_code"
    t.string   "plan_name"
    t.text     "plan_description"
    t.integer  "price"
    t.string   "frequency"
    t.string   "image_url"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
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
  end

end
