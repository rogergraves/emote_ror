# == Schema Information
# Schema version: 20110620133338
#
# Table name: surveys
#
#  id                        :integer(4)      not null, primary key
#  user_id                   :integer(4)
#  project_name              :string(255)     not null
#  score                     :float           default(0.0)
#  responses_count           :integer(4)      default(0)
#  public                    :boolean(1)      default(FALSE)
#  created_at                :datetime
#  updated_at                :datetime
#  code                      :string(20)      not null
#  action_token              :string(255)
#  state                     :integer(4)      default(0), not null
#  scorecard_code            :string(20)      not null
#  activated_at              :datetime
#  scorecard_viewed_at       :datetime
#  store_respondent_contacts :boolean(1)      default(FALSE)
#  feedback_prompt           :string(255)     default("")
#

require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
