require "test_helper"

class ReportCard::PositionalScoreTest < ActiveSupport::TestCase

  test "Converting number to checkmark in a position" do
    assert_equal ["", "✓", ""], ReportCard::PositionalScore.new(1).to_a
  end
end
