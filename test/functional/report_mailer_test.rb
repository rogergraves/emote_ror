require 'test_helper'

class ReportMailerTest < ActionMailer::TestCase
  test "emote_activity" do
    mail = ReportMailer.emote_activity
    assert_equal "Emote activity", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
