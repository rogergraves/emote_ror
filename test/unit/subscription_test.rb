# == Schema Information
# Schema version: 20110417191406
#
# Table name: subscriptions
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  emote_amount :integer(4)      default(0)
#  created_at   :datetime
#  updated_at   :datetime
#  start_date   :datetime        not null
#  end_date     :datetime        not null
#  kind         :string(255)     not null
#

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
