module Gapps
  module CustomEmployeeFields
    extend ActiveSupport::Concern

    def gapps_external_ids
      [
        {
          "type" => "custom",
          "customType" => "person_id",
          "value" => self.id
        },
        {
          "type" => "custom",
          "customType" => "school_id",
          "value" => gapps_site_code
        }
      ]
    end

    def gapps_site_code
      primary_site.code
    end

  end
end
