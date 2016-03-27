module Gapps
  module Api

    class Base
      include ActiveModel::Validations
      
      def self.service
        GAdmin::DirectoryService.new
      end

      def service
        @service ||= GAdmin::DirectoryService.new
      end
    end

  end
end
