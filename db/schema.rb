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

ActiveRecord::Schema.define(:version => 20140205042538) do

  create_table "admins", :force => true do |t|
    t.text     "email"
    t.text     "encrypted_password"
    t.text     "password_salt"
    t.text     "reset_password_token"
    t.text     "remember_token"
    t.text     "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text     "current_sign_in_ip"
    t.text     "last_sign_in_ip"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "subject_id"
    t.text     "creator_type"
    t.text     "subject_type"
    t.string   "text"
    t.integer  "archived"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "user_id"
    t.text     "source"
    t.text     "token"
    t.datetime "purchase_date"
    t.float    "total_paid"
    t.text     "customer_name"
    t.text     "customer_id"
    t.text     "customer_address"
    t.text     "customer_email"
    t.text     "customer_phone"
    t.text     "description"
    t.text     "currency"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "emote_amount"
    t.datetime "start_date"
    t.datetime "end_date"
    t.text     "kind"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "survey_demo_results", :force => true do |t|
    t.integer  "survey_result_id"
    t.text     "question"
    t.string   "answer"
    t.text     "question_field"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "survey_results", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "ip"
    t.text     "emote"
    t.integer  "intensity_level"
    t.string   "verbatim"
    t.text     "code"
    t.integer  "is_removed"
    t.text     "email"
    t.integer  "email_used"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "survey_user_data", :force => true do |t|
    t.integer  "survey_result_id"
    t.text     "name"
    t.text     "email"
    t.text     "phone"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "surveys", :force => true do |t|
    t.integer  "user_id"
    t.text     "project_name"
    t.float    "score"
    t.integer  "response_count"
    t.integer  "public"
    t.text     "code"
    t.text     "action_token"
    t.integer  "state"
    t.text     "scorecard_code"
    t.datetime "activated_at"
    t.datetime "scorecard_viewed_at"
    t.integer  "store_respondent_contracts"
    t.text     "feedback_prompt"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "users", :force => true do |t|
    t.text     "email"
    t.text     "encrypted_password"
    t.text     "password_salt"
    t.text     "reset_password_token"
    t.text     "remember_token"
    t.text     "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.text     "current_sign_in_ip"
    t.text     "full_name"
    t.text     "country_code"
    t.text     "company"
    t.text     "job_title"
    t.text     "phone_number"
    t.text     "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "banned"
    t.integer  "surveys_count"
    t.integer  "subscriptions_count"
    t.text     "activity_report_interval"
    t.datetime "activity_report_sent_at"
    t.text     "partner_code"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

end
