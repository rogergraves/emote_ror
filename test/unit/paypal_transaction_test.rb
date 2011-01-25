# == Schema Information
# Schema version: 20110123204321
#
# Table name: paypal_transactions
#
#  id               :integer(4)      not null, primary key
#  user_id          :integer(4)
#  subscription_id  :integer(4)
#  token            :string(255)
#  date             :string(255)
#  total            :string(255)
#  customer_name    :string(255)
#  customer_id      :string(255)
#  customer_address :string(255)
#  customer_email   :string(255)
#  customer_phone   :string(255)
#  description      :string(255)
#  currency         :string(255)     default("USD")
#  product_code     :string(255)
#

require 'test_helper'

class PaypalTransactionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
