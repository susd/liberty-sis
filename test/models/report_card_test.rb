# == Schema Information
#
# Table name: report_cards
#
#  id                            :integer          not null, primary key
#  student_id                    :integer
#  report_card_form_id           :integer
#  data                          :jsonb
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  import_details                :jsonb            default({}), not null
#  report_card_grading_period_id :integer
#

require 'test_helper'

class ReportCardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
