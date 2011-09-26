require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "signup" do
    mail = AdminMailer.signup
    assert_equal "Signup", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "upgrade" do
    mail = AdminMailer.upgrade
    assert_equal "Upgrade", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
