# == Schema Information
#
# Table name: report_card_comments
#
#  id                           :integer          not null, primary key
#  english                      :text
#  spanish                      :text
#  report_card_comment_group_id :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

require 'test_helper'

class ReportCard::CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
