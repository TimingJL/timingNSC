require 'test_helper'

class ExportMailerTest < ActionMailer::TestCase
  test "inform" do
    mail = ExportMailer.inform
    assert_equal "Inform", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
