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

ActiveRecord::Schema.define(:version => 20110606172324) do

  create_table "admins", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "notes", :force => true do |t|
    t.integer  "creator_id",                                    :null => false
    t.integer  "subject_id"
    t.string   "creator_type", :limit => 30,                    :null => false
    t.string   "subject_type", :limit => 30
    t.text     "text"
    t.boolean  "archived",                   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "user_id"
    t.string   "source",                                            :null => false
    t.string   "token"
    t.datetime "purchase_date"
    t.float    "total_paid",                     :default => 0.0,   :null => false
    t.string   "customer_name"
    t.string   "customer_id",      :limit => 64
    t.string   "customer_address"
    t.string   "customer_email"
    t.string   "customer_phone",   :limit => 50
    t.string   "description"
    t.string   "currency",         :limit => 10, :default => "USD"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "emote_amount",               :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_date",                                :null => false
    t.datetime "end_date",                                  :null => false
    t.string   "kind",         :limit => 20,                :null => false
  end

  create_table "survey_demo_result", :primary_key => "survey_demo_result_id", :force => true do |t|
    t.integer "survey_result_id", :limit => 8,        :null => false
    t.string  "question"
    t.text    "answer",           :limit => 16777215
    t.string  "question_field"
  end

  add_index "survey_demo_result", ["survey_result_id"], :name => "survey_result_id"

  create_table "survey_result", :primary_key => "survey_result_id", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "ip",              :limit => 50
    t.string   "emote"
    t.integer  "intensity_level"
    t.text     "verbatim",        :limit => 16777215
    t.string   "code"
    t.integer  "is_removed",      :limit => 1,        :default => 0
  end

  create_table "survey_user_data", :primary_key => "survey_user_data_id", :force => true do |t|
    t.integer "survey_result_id", :limit => 8, :null => false
    t.string  "name"
    t.string  "email"
    t.string  "phone"
  end

  add_index "survey_user_data", ["survey_result_id"], :name => "survey_result_id"

  create_table "surveys", :force => true do |t|
    t.integer  "user_id"
    t.string   "project_name",                                               :null => false
    t.float    "score",                                   :default => 0.0
    t.integer  "responses_count",                         :default => 0
    t.boolean  "public",                                  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code",                      :limit => 20,                    :null => false
    t.string   "action_token"
    t.integer  "state",                                   :default => 0,     :null => false
    t.string   "scorecard_code",            :limit => 20,                    :null => false
    t.datetime "activated_at"
    t.datetime "scorecard_viewed_at"
    t.boolean  "store_respondent_contacts",               :default => false
  end

  add_index "surveys", ["code"], :name => "index_surveys_on_code", :unique => true
  add_index "surveys", ["scorecard_code"], :name => "index_surveys_on_scorecard_code", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                                   :default => "",                    :null => false
    t.string   "encrypted_password",       :limit => 128, :default => "",                    :null => false
    t.string   "password_salt",                           :default => "",                    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "full_name",                :limit => 100
    t.string   "country_code",             :limit => 20
    t.string   "company",                  :limit => 60
    t.string   "job_title",                :limit => 60
    t.string   "phone_number",             :limit => 25
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "banned",                                  :default => false
    t.integer  "surveys_count",                           :default => 0
    t.integer  "subscriptions_count",                     :default => 0
    t.string   "activity_report_interval", :limit => 15,  :default => "none"
    t.datetime "activity_report_sent_at",                 :default => '1970-01-01 03:00:00'
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
