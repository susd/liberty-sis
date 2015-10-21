# == Schema Information
#
# Table name: report_card_comment_groups
#
#  id                  :integer          not null, primary key
#  name                :string
#  report_card_form_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class ReportCard::CommentGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
