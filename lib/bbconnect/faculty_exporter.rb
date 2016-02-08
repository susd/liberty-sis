module Bbconnect
  class FacultyExporter
    PATH = Rails.root.join('tmp', 'data', 'bbconnect', 'faculty.csv')

    def self.export_many(employee_relation, path = nil)
      path ||= PATH
      CSV.open(path, 'w') do |csv|
        csv << header
        employee_relation.includes(:contacts, :site).find_each do |employee|
          csv << new(employee).export
        end
      end
    end

    def self.header
      %w{
        referencecode
        institution
        FirstName
        LastName
        homephone
        emailaddress
        Contacttype
      }
    end

    attr_reader :employee

    def initialize(employee)
      @employee = employee
    end

    def export
      [
        ref_id,
        site_abbr,
        employee.first_name,
        employee.last_name,
        '',
        employee.email,
        'faculty'
      ]
    end

    def ref_id
      "FAC#{employee.import_details['import_id']}"
    end

    def site_abbr
      if employee.primary_site.present?
        employee.primary_site.abbr
      else
        'NA'
      end
    end

  end
end
