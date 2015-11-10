# == Schema Information
#
# Table name: phones
#
#  id            :integer          not null, primary key
#  label         :string
#  original      :string
#  number        :integer
#  callable_id   :integer
#  callable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
