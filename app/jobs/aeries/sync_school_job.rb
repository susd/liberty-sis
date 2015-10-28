module Aeries
  class SyncSchoolJob < ActiveJob::Base
    queue_as :pdf

    # after_perform do
    #   SyncSchoolJob.set(wait: 1.hour).perform_later
    # end

    def perform(school_code)
      Aeries::SchoolImporter.new(school_code).import_recent!
    end
  end
end
