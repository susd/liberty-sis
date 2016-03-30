module Gapps
  class SyncOrgUnitJob < ActiveJob::Base
    queue_as :gapps

    def perform(persona)
      Gapps::Api::OrgUnit.new(persona).upsert
    end
  end
end
