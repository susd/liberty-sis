module Aeries
  class SchoolImporter

    def initialize(school_code)
      @code = school_code
    end

    def import!
      Aeries::Teacher.active_by_site(@code).pluck(:tn).each do |teacher_num|
        ClassroomImporter.new(@code, teacher_num).import!
      end
    end

  end
end
