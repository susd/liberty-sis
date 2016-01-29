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
      @builder[:year] = SchoolYear.year_for(DateTime.parse(@data['created_at']))
      @builder[:data] = {
        'comments' => extract_comments,
        'subjects' => extract_subjects,
        'attendance' => extract_attendance
      }
      @builder[:import_details] = {
        import_id: path
      }
    end

    def extract_comments
      hsh = {}
      data['data']['comments'].each_with_index do |cmts, idx|
        if cmts[(idx + 1).to_s]
          hsh[(idx + 1).to_s] = {'comment_ids' => cmts[(idx + 1).to_s].map{|e| @form.comments.find_by(english: e).try(:id) }.compact}
        end
      end
      hsh
    end

    def extract_subjects
      hsh = {}
      data['data']['subjects'].each do |sub_hsh|
        subject = @form.subjects.find_by(slug: sub_hsh.first[0])
        if subject
          hsh[subject.id.to_s] = sub_hsh.first[1]
        end
      end
      hsh
    end

    def extract_attendance
      data['data']['attendance']
    end

    def corresponding_card
      @card ||= begin
        if hit = ReportCard.find_by(year: @builder[:year], student: @builder[:student])
          hit
        else
          ReportCard.new(student: @builder[:student], year: @builder[:year], form: @builder[:form])
        end
      end
    end

    def import!
      if @builder[:student].nil?
        false
      else
        card = corresponding_card
        card.import_details = @builder[:import_details]
        card.data.deep_merge!(@builder[:data])
        card.save
      end
    end

  end
end
