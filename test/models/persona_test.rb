# == Schema Information
#
# Table name: personas
#
#  id         :integer          not null, primary key
#  student_id :integer
#  handler    :string
#  username   :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PersonaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
