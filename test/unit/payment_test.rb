# == Schema Information
# Schema version: 20110417191406
#
# Table name: payments
#
#  id               :integer(4)      not null, primary key
#  user_id          :integer(4)
#  source           :string(255)     not null
#  token            :string(255)
#  purchase_date    :datetime
#  total_paid       :float           default(0.0), not null
#  customer_name    :string(255)
#  customer_id      :string(64)
#  customer_address :string(255)
#  customer_email   :string(255)
#  customer_phone   :string(50)
#  description      :string(255)
#  currency         :string(10)      default("USD")
#  created_at       :datetime
#  updated_at       :datetime
#

require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
