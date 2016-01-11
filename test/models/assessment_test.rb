# == Schema Information
#
# Table name: assessments
#
#  id         :integer          not null, primary key
#  student_id :integer
#  name       :string
#  data       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class AssessmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
