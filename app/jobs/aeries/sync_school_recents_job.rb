module Aeries
  class SyncSchoolRecentsJob < ActiveJob::Base
    queue_as :sync

    after_perform do |job|
      SyncSchoolJob.set(wait: 2.hours).perform_later(*job.arguments)
    end

    def perform(school_code)
      Aeries::SchoolImporter.new(school_code).import_recent!
    end
  end
end