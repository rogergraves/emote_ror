# == Schema Information
# Schema version: 20110220073519
#
# Table name: notes
#
#  id           :integer(4)      not null, primary key
#  creator_id   :integer(4)      not null
#  subject_id   :integer(4)
#  creator_type :string(30)      not null
#  subject_type :string(30)
#  text         :text
#  archived     :boolean(1)      default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
