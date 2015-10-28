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

class SyncEvent < ActiveRecord::Base
  belongs_to :syncable, polymorphic: true

  enum state: {pending: 0, succeeded: 1, failed: 2}
  enum action: {read: 0, write: 1, export: 2}
end
