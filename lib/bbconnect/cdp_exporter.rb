require 'csv'

module Bbconnect
  class CdpExporter
    SOURCE = Rails.root.join('tmp', 'data', 'bbconnect', 'from_ezcare.csv')
    TARGET = Rails.root.join('tmp', 'data', 'bbconnect', 'cdp.csv')

    def self.from_csv(source = SOURCE, target = TARGET)
      CSV.open(target, 'w') do |csv|
        csv << header
        CSV.foreach(source, headers: true) do |row|
          csv << new(row).export
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

    attr_reader :data

    def initialize(row)
      @data = row
    end

    def export
      [
        ref_id,     # ref code
        'Student',  # type
        data[2],    # first name
        data[1],    # last name
        data[3],    # status (grade)
        language,
        gender,
        data[8],    # primary phone
        data[9],    # home phone
        data[10],   # work phone
        data[11],   # work phone alt
        data[12],   # email
        site
      ]
    end

    # Offset EZCare id to avoid collision with Aeries
    def ref_id
      300_000_000 + data[0].to_i
    end

    def language
      data[4] == 'Yes' ? '01' : '00'
    end

    def gender
      data[5][0].upcase
    end

    def site
      abbr = Site.find_by(code: data[6].to_i).abbr
      "cdp-#{abbr}"
    end
  end
end
