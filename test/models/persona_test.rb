# == Schema Information
#
# Table name: personas
#
#  id              :integer          not null, primary key
#  student_id      :integer
#  handler         :string
#  username        :string
#  password        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  state           :integer          default(0), not null
#  service_id      :string
#  service_data    :jsonb            not null
#  synced_at       :datetime
#  personable_id   :integer
#  personable_type :string           default("Student")
#

require 'test_helper'

class PersonaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
