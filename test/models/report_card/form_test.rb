# == Schema Information
#
# Table name: report_card_forms
#
#  id         :integer          not null, primary key
#  name       :string
#  renderer   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ReportCard::FormTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
