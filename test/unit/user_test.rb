# == Schema Information
# Schema version: 20110606172324
#
# Table name: users
#
#  id                       :integer(4)      not null, primary key
#  email                    :string(255)     default(""), not null
#  encrypted_password       :string(128)     default(""), not null
#  password_salt            :string(255)     default(""), not null
#  reset_password_token     :string(255)
#  remember_token           :string(255)
#  remember_created_at      :datetime
#  sign_in_count            :integer(4)      default(0)
#  current_sign_in_at       :datetime
#  last_sign_in_at          :datetime
#  current_sign_in_ip       :string(255)
#  last_sign_in_ip          :string(255)
#  full_name                :string(100)
#  country_code             :string(20)
#  company                  :string(60)
#  job_title                :string(60)
#  phone_number             :string(25)
#  created_at               :datetime
#  updated_at               :datetime
#  confirmation_token       :string(255)
#  confirmed_at             :datetime
#  confirmation_sent_at     :datetime
#  banned                   :boolean(1)      default(FALSE)
#  surveys_count            :integer(4)      default(0)
#  subscriptions_count      :integer(4)      default(0)
#  activity_report_interval :string(15)      default("none")
#  activity_report_sent_at  :datetime        default(Thu Jan 01 02:00:00 UTC 1970)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
