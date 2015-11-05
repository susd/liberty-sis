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

    def import_recent!
      Aeries::Teacher.active_by_site(@code).pluck(:tn).each do |teacher_num|
        if SyncEvent.where(label: "students:recent/#{@code}").any?
          since = SyncEvent.where(label: "students:recent/#{@code}").maximum(:created_at)
        else
          since = ::Student.where(site: Site.find_by(code: @code)).maximum(:created_at)
        end
        ClassroomImporter.new(@code, teacher_num).import_recent!(since)
      end
    end

  end
end
