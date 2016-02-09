module Ischool
  class EmployeeImporter

    def self.import_each(ischool_employee_relation)
      ischool_employee_relation.find_each do |employee|
        new(employee).import!
      end
    end

    def self.import_titles(teacher_relation)
      teacher_relation.find_each do |teacher|
        ischool_employee = Ischool::Employee.find(teacher.import_details['import_id'])
        teacher.update(title: ischool_employee.attributes['Title'])
      end
    end

    attr_reader :employee

    def initialize(ischool_employee)
      @employee = ischool_employee
    end

    def import!
      if exists?
        native.update(attrs)
      else
        @native = ::Employee.create(attrs)
      end

      Ischool::EmployeeContactImporter.new(@employee).import

      native.clean_sites

      native
    end

    def native
      @native ||= ::Employee.find_by([
        "import_details @> ?", employee.import_details.to_json
        ])
    end

    def exists?
      native.present?
    end

    def attrs
      @attrs ||= begin
        hsh = employee.to_employee
        hsh.merge(user: user) if user.present?
        hsh
      end
    end

    def user
      @user ||= User.find_by(email: employee.email)
    end

  end
end
