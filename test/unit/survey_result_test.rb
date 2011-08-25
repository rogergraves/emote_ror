# == Schema Information
# Schema version: 20110725234250
#
# Table name: survey_result
#
#  survey_result_id :integer(8)      not null, primary key
#  start_time       :datetime
#  end_time         :datetime
#  ip               :string(50)
#  emote            :string(255)
#  intensity_level  :integer(4)
#  verbatim         :text(16777215)
#  code             :string(255)
#  is_removed       :integer(1)      default(0)
#  email            :string(255)
#  email_used       :boolean(1)      default(FALSE)
#

require 'test_helper'

class SurveyResultTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
