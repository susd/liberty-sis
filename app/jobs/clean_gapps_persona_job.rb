class CleanGappsPersonaJob < ActiveJob::Base
  queue_as :persona

  def perform(student)
    begin
      old_email = student.first_name
      old_email << (student.middle_name.blank? ? '' : student.middle_name[0])
      old_email << student.last_name
      old_email << student.grad_year.to_s[-2,2]
      old_email << "@#{student.persona_domain}"
      old_email = old_email.downcase.gsub(/(\s|-|\'|\")/,'')

      if user = Gapps::Api::Student.find(old_email)
        Gapps::Base.service.delete_user(user.id)
      end

    rescue Google::Apis::ClientError
      true
    end
  end
end
