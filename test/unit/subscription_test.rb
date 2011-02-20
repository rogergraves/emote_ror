# == Schema Information
# Schema version: 20110220073519
#
# Table name: subscriptions
#
#  id               :integer(4)      not null, primary key
#  user_id          :integer(4)
#  emote_amount     :integer(4)      default(0)
#  created_at       :datetime
#  updated_at       :datetime
#  start_date       :datetime        not null
#  end_date         :datetime        not null
#  kind             :integer(4)      default(0), not null
#  token            :string(255)
#  purchase_date    :datetime
#  total_paid       :float           default(0.0), not null
#  customer_name    :string(255)
#  customer_id      :string(32)
#  customer_address :string(255)
#  customer_email   :string(255)
#  customer_phone   :string(50)
#  description      :string(255)
#  product_code     :string(64)
#  currency         :string(10)      default("USD")
#

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
