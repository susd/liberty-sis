# == Schema Information
#
# Table name: sync_events
#
#  id            :integer          not null, primary key
#  label         :string
#  state         :integer          default(0), not null
#  action        :integer          default(0), not null
#  syncable_id   :integer
#  syncable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class SyncEventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
