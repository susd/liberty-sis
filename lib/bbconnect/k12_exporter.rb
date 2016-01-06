require 'csv'

module Bbconnect
  class K12Exporter
    PATH = Rails.root.join('tmp', 'data', 'bbconnect', 'k12.csv')

    def self.export_many(student_relation, path = nil)
      path ||= PATH
      CSV.open(path, 'w') do |csv|
        csv << header
        student_relation.includes(:contacts, :site, :grade).find_each do |student|
          csv << new(student).export
        end
      end
    end

    def self.header
      %w{
        referencecode
        contacttype
        firstname
        lastname
        status
        language
        gender
        primaryphone
        homephone
        workphone
        workphonealt
        emailaddress
        institution
      }
    end

    attr_reader :student

    def initialize(student)
      @student = student
    end

    def export
      [
        import_id,
        "Student",
        student.first_name,
        student.last_name,
        student.grade.simple,
        language,
        student.sex,
        primary_phone,
        home_phone,
        workphone,
        workphone_alt,
        email,
        student.site.abbr.upcase
      ]
    end

    def import_id
      student.import_details['import_id']
    end

    def primary_phone
      @primary ||= home_contact.phones.find_by(label: 'primary_phone').try(:normal)
    end

    def home_phone
      primary_phone
    end

    def workphone
      home_contact.phones.find_by(label: 'father_work').try(:normal)
    end

    def workphone_alt
      home_contact.phones.find_by(label: 'mother_work').try(:normal)
    end

    def email
      home_contact.email
    end

    def language
      ("%02d" % student.home_lang.aeries_code)
    end

    def home_contact
      @contact ||= student.contacts.includes(:phones).find_by(label: 'home')
    end

  end
end
