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

ActiveRecord::Schema.define(:version => 20120521235624) do

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "target_type"
    t.integer  "target_id"
    t.string   "target_action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "airports", :force => true do |t|
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", :force => true do |t|
    t.string   "type"
    t.integer  "purchaseorder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body"
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "item_codes", :force => true do |t|
    t.string   "code"
    t.string   "species"
    t.string   "subspecies"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "purchaseorder_id"
    t.integer  "box_number"
    t.integer  "item_number"
    t.float    "weight"
    t.string   "code"
    t.float    "cost"
    t.string   "grade_notes"
    t.string   "description"
    t.string   "species"
    t.string   "subspecies"
    t.string   "shipper_grade"
    t.string   "core_grade"
    t.string   "freshness_grade"
    t.string   "texture_grade"
    t.string   "tail_grade"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.boolean  "graded"
  end

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.string   "subject_class"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchaseorders", :force => true do |t|
    t.integer  "po_number"
    t.date     "po_date"
    t.integer  "shipper_id"
    t.boolean  "active"
    t.string   "locale"
    t.string   "origin"
    t.string   "airline"
    t.string   "customs_broker"
    t.date     "date_of_arrival"
    t.integer  "warehouse_id"
    t.integer  "airport_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "graded"
  end

  create_table "shippers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "role"
    t.integer  "warehouse_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "warehouses", :force => true do |t|
    t.string   "short_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
