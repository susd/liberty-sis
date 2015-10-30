module Aeries
  class EnrollmentImporter
    attr_reader :enrollment

    def initialize(aeries_enrollment)
      @enrollment = aeries_enrollment
    end

    def import!
      if exists?
        native.update(@enrollment.to_enrollment)
      else
        @native = ::Enrollment.create(@enrollment.to_enrollment)
      end
      native
    end

    def native
      @native ||= find_native
    end

    def find_native
      ::Enrollment.find_by(["import_details @> ?", @enrollment.import_ids.to_json])
    end

    def exists?
      native.present?
    end

  end
end
