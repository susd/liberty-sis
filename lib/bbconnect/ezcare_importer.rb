require 'csv'

module Bbconnect
  class EzcareImporter
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def data
      @data ||= CSV.table(path)
    end

    def import
      data.each do |row|
        import_row(row)
      end
    end

    def import_row(row)
      # student find or create
    end

    def student_hash(row)
      {
        first_name: row[1],
        last_name: row[2],
        grade: liberty_grade(row[3]),
        sex: gender(row[5]),
        site: parse_location(row[6])

      }
    end

    def liberty_grade(grd)
      if grd.downcase = 'k'
        grd = 0
      else
        grd = grd.to_i
      end

      Grade.find_by(legacy_id: grd)
    end

    def gender(str)
      str.downcase == 'male' ? 'M' : 'F'
    end

    def parse_location(loc)
      Site.find_by(code: (loc.to_i + 1))
    end

  end
end
