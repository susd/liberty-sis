module Gapps
  class SyncOrgUnitJob < ActiveJob::Base

    def perform(native_org_unit)
      Gapps::Api::OrgUnit.new(native_org_unit).upsert
    end
  end
end
