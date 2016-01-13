module Aeries
  class SyncSchoolJob < ActiveJob::Base
    queue_as :sync

    def perform(school_code)
      Aeries::SchoolImporter.new(school_code).import!
    end
  end
end
