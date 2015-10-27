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
      @builder[:student] = Student.find_by(["import_details -> 'import_id' = ?", @data['student_id'].to_json])
      @builder[:year] = ReportCard::GradingPeriod.school_year_for(DateTime.parse(@data['created_at']))
      @builder[:data] = {
        comments: extract_comments,
        subjects: extract_subjects,
        attendance: extract_attendance
      }
    end

    def extract_comments
      hsh = {}
      data['data']['comments'].each_with_index do |cmts, idx|
        hsh[idx + 1] = {comment_ids: cmts[(idx + 1).to_s].map{|e| @form.comments.find_by(english: e).id }}
      end
      hsh
    end

    def extract_subjects
      hsh = {subjects: {}}
      data['data']['subjects'].each do |sub_hsh|
        subject = @form.subjects.find_by(slug: sub_hsh.first[0])
        hsh[:subjects][subject.id] = sub_hsh.first[1]
      end
      hsh
    end

    def extract_attendance
      data['data']['attendance']
    end

  end
end
