class SyncEvent < ActiveRecord::Base
  belongs_to :syncable, polymorphic: true

  enum state: {pending: 0, succeeded: 1, failed: 2}
  enum action: {read: 0, write: 1, export: 2}
end
