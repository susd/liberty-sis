class VerifyGappsPersonaJob < ActiveJob::Base
  queue_as :persona

  def perform(student)
    begin
      Gapps::Api::Student.find(student.persona_email)
    rescue Google::Apis::ClientError
      Gapps::Api::Student.new(student).insert!
    end
  end
end
