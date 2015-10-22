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
      native_employee = ::Employee.find_by(["import_details -> 'import_id' = ?", employee.id.to_json])
      if native_employee.nil?
        native_employee = ::Employee.new
      end
      native_employee.assign_attributes(attrs)
      native_employee.user = user if user
      native_employee.save
      native_employee.update_sites

      native_employee
    end

    def attrs
      employee.to_employee
    end

    def user
      @user ||= User.find_by(email: attrs[:email])
    end
  end
end
