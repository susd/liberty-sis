module Aeries
  class TeacherImporter

    attr_reader :teacher, :site

    def initialize(aeries_teacher)
      @teacher = aeries_teacher
      @site = Site.find_by(code: @teacher.attributes['sc'].to_i)
    end

    def import!
      create_or_update_teacher
    end

    def create_or_update_teacher(additional_attrs = {})
      attrs = teacher.to_teacher.merge!(additional_attrs)
      if existing_teacher = ::Teacher.find_by("import_details -> 'import_id' = ?", teacher.attributes['id'].to_s)
        existing_teacher.update(attrs)
        native_teacher = existing_teacher
      else
        native_teacher = ::Teacher.create(attrs)
      end
      native_teacher
    end

  end
end
