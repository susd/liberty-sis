module Ischool
  class EmployeeContactImporter < ::ContactImporter
    attr_reader :employee

    def initialize(ischool_employee)
      @employee = ischool_employee
    end

    def contact_attrs
      {
        label: 'home',
        contactable: native_employee,
        first_name:  employee.attributes['FirstName'],
        last_name:   employee.attributes['LastName'],
        email:       employee.email,
        position: 0,
        import_details: {
          source: 'ischool',
          import_class: self.class.to_s,
          import_id: employee.id
        }
      }
    end

    def address_attrs
      [
        {
          label: "home",
          street: employee.attributes["Address"],
          city:   employee.attributes["City"],
          state:  employee.attributes["State"],
          zip:    employee.attributes["Zip"]
        }
      ]
    end

    def phone_attrs
      [
        {label: "home", original: employee.attributes["Phone1"]},
        {label: "alt",  original: employee.attributes["Phone2"]}
      ]
    end

    def native_employee
      @native_employee ||= ::Employee.find_by(["import_details @> ?", employee.import_details.to_json])
    end

    def import_details
      {
        source: 'ischool',
        import_class: self.class.to_s,
        import_id: employee.id
      }
    end

  end
end
