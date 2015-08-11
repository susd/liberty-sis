# == Schema Information
#
# Table name: grades
#
#  id         :integer          not null, primary key
#  name       :text
#  position   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  legacy_id  :integer          default(0), not null
#

require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
