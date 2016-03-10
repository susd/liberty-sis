class SyncGappsPersonaJob < ActiveJob::Base
  queue_as :persona

  def perform(student)
    Gapps::Api::Student.new(student).upsert!
  end
end
