class VerifyGappsPersonaJob < ActiveJob::Base
  queue_as :persona

  def perform(student)
    begin
      Gapps::Student.find(student.persona_email)
    rescue Google::Apis::ClientError
      Gapps::Student.new(student).insert!
    end
  end
end
