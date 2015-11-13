# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  contactable_id   :integer
#  contactable_type :string
#  label            :string
#  first_name       :string
#  last_name        :string
#  email            :string
#  note             :text
#  import_details   :jsonb
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  relationship     :string
#

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
