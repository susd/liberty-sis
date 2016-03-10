module Gapps
  module Api

    class Base
      def self.service
        GAdmin::DirectoryService.new
      end

      def service
        @service ||= GAdmin::DirectoryService.new
      end
    end

  end
end
