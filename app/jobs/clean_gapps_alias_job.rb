class CleanGappsAliasJob < ActiveJob::Base

  def perform(gapps_id)
    service = Gapps::Base.service

    user = service.get_user(gapps_id)

    if user.aliases && user.aliases.any?
      aliases = user.aliases.find_all{|a| a =~ /hi\.saugususd/ }

      # patch user
      if aliases.any?
        service.batch do |srv|
          aliases.each{|a| srv.delete_user_alias(user.id, a) }
        end
      end
    end

  end
end
