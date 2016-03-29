module Gapps
  module CustomStudentFields
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
        },
        {
          "type" => "custom",
          "customType" => "grade",
          "value" => gapps_grade
        }
      ]
    end

    def gapps_grade
      grade.simple
    end

    def gapps_site_code
      site.code
    end

  end
end
