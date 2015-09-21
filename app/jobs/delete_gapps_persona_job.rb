class DeleteGappsPersonaJob < ActiveJob::Base
  queue_as :persona

  def perform(persona)
    if persona.handler == 'gapps'
      service.delete_user(persona.service_id) do |res, err|
        if err
          persona.update(state: 2)
        else
          persona.destroy
        end
      end
    end
  end

  def service
    @service ||= Gapps::Base.service
  end
end
