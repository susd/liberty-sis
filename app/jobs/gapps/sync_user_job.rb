module Gapps
  class SyncUserJob < ActiveJob::Base
    queue_as :gapps

    def perform(native_person)
      Gapps::Api::User.new(native_person).upsert
    end
  end
end
