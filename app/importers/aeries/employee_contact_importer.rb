module Aeries
  class EmployeeContactImporter < ::ContactImporter
    attr_reader :employee

    def initialize(aeries_teacher)
      @employee = aeries_teacher
    end

    def contact_attrs
      {
        label: "home",
        contactable: native_employee,
        first_name:  employee.attributes["tf"],
        last_name:   employee.attributes["tln"],
        position: 0,
        import_details: {
          source: "ischool",
          import_class: self.class.to_s,
          import_id: employee.attributes["id"]
        }
      }
    end

    def address_attrs
      [
        {
          label: "home",
          street: employee.staff_record.attributes["ad"],
          city:   employee.staff_record.attributes["cy"],
          state:  employee.staff_record.attributes["st"],
          zip:    employee.staff_record.attributes["zc"]
        }
      ]
    end

    def phone_attrs
      [
        {label: "home", original: employee.staff_record.attributes["tl"]}
      ]
    end

    def native_employee
      @native_employee ||= ::Employee.find_by(["import_details @> ?", employee.import_ids.to_json])
    end

    def import_details
      {
        source: "aeries",
        import_class: self.class.to_s,
        import_id: employee.attributes["id"]
      }
    end
  end
end
