module Ischool
  class EmployeeImporter

    def self.import_each(ischool_employee_relation)
      ischool_employee_relation.find_each do |employee|
        new(employee).import!
      end
    end

    attr_reader :employee

    def initialize(ischool_employee)
      @employee = ischool_employee
    end

    def import!
      native_employee = ::Employee.find_or_initialize_by(["import_details -> 'import_id' = ?", employee.id.to_json])
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
