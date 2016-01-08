module Aeries
  class SyncContactsJob < ActiveJob::Base
    queue_as :sync

    def perform(student)
      Aeries::ContactImporter.for_student(student)
      Aeries::HomeContactImporter.for_student(student)
    end
  end
end
