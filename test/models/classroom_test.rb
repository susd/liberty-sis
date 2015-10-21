# == Schema Information
#
# Table name: classrooms
#
#  id                 :integer          not null, primary key
#  name               :string
#  site_id            :integer
#  import_details     :jsonb            default({}), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  primary_teacher_id :integer
#

require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
