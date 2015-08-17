class SyncGappsPersonaJob < ActiveJob::Base
  queue_as :persona

  def perform(student)
    Gapps::Student.new(student).upsert!
  end
end
