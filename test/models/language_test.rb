# == Schema Information
#
# Table name: languages
#
#  id           :integer          not null, primary key
#  name         :text
#  calpads_name :text
#  calpads_code :integer
#  aeries_code  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  locale       :string
#

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
