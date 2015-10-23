module ReportCards
  class JsonImporter
    attr_reader :path, :data, :builder

    def initialize(path)
      @path = path
      @data = JSON.parse File.new(path).read
      @form = ReportCard::Form.find_by(renderer: @data['form_id'])
      extract_data
    end

    def extract_data
      @builder = {}
      @builder[:form] = @form
      @builder[:student] = Student.find_by(["import_details -> 'import_id' = ?", @data['student_id']])
      @builder[:year] = ReportCard::GradingPeriod.school_year_for(DateTime.parse(@data['created_at']))
      @builder[:data] = {
        comments: extract_comments,
        subjects: extract_subjects,
        attendance: extract_attendance
      }
    end

    def extract_comments
      hsh = {}
      data['data']['comments'].each do |p, cmts|
        hsh[p] = cmts.map{|e| @form.comments.find_by(english: e).id }
      end
      hsh
    end

    def extract_subjects

    end

    def extract_attendance
      
    end

  end
end
