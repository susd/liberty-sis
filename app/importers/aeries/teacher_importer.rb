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

      native_teacher = ::Teacher.find_or_initialize_by(native_selector)
      native_teacher.assign_attributes(attrs)
      associate_user(native_teacher)

      native_teacher.save
      native_teacher
    end

    private

    def associate_user(native_teacher)
      if native_teacher.user.nil?

        if user = User.find_by(email: native_teacher.email)
          native_teacher.user = user
          native_teacher.user.add_role ::Role.teacher
        end

      end
    end

    def native_selector
      ["import_details -> 'import_id' = ?", teacher.attributes['id'].to_s]
    end

  end
end
