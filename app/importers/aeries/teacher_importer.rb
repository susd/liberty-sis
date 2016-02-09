module Aeries
  class TeacherImporter

    def self.import_each(aeries_teacher_relation)
      aeries_teacher_relation.find_each do |tch|
        new(tch).import!
      end
    end

    attr_reader :teacher, :site

    def initialize(aeries_teacher)
      @teacher = aeries_teacher
      @site = Site.find_by(code: @teacher.attributes['sc'].to_i)
    end

    def import!
      SyncEvent.wrap(label: "aeries:teacher") do |event|
        if exists?
          native.update(teacher_attrs)
        else
          @native = ::Teacher.create(teacher_attrs)
        end

        if native.user.present?
          native.user.add_role(::Role.teacher)
        end

        Aeries::EmployeeContactImporter.new(teacher).import

        event.syncable = native
      end

      native
    end

    def import_if_fresh!
      if fresh?
        import!
      end

      native
    end

    def fresh?
      return true if native.nil?

      aeries_stamp = teacher.dts
      last_import = native.sync_events.maximum(:created_at)

      (aeries_stamp && last_import) && (aeries_stamp > last_import)
    end

    def native
      @native ||= find_native
    end

    def find_native
      ::Teacher.find_by(["import_details @> ?", @teacher.import_ids.to_json])
    end

    def teacher_attrs
      @attrs ||= begin
        hsh = teacher.to_teacher
        hsh.merge(user: user) if user.present?

        hsh
      end
    end

    def exists?
      native.present?
    end

    # def associate_user
    #   if native.user.nil?
    #     if user = User.find_by(email: native.email)
    #       native.user = user
    #       native.user.add_role ::Role.teacher
    #     end
    #   end
    # end

    def user
      @user ||= User.find_by(email: native.email)
    end

  end
end
