module Ischool
  class ReportCardImporter

    def self.import_classroom(classroom)
      Aeries::AttendanceImporter.import_classroom(classroom)
      classroom.students.each do |student|
        all_for_student(student)
      end
    end

    def self.all_for_student(student)
      Ischool::Form.cards.for_student(student).each do |form|
        new(form, student).import!
      end
    end

    attr_reader :native_form, :form, :student, :card

    def initialize(ischool_form, student)
      @form = ischool_form
      @student = student
      @data = Hash.new{|h,k| h[k] = Hash.new(&h.default_proc) }
      unless missing_data?
        choose_parser
      end
    end

    def card
      @card ||= corresponding_card
    end

    def import!
      return false if missing_data?

      parsed = @parser.parse!

      if card.new_record?
        card.data = parsed
      else
        card.data.merge! parsed
      end

      card.form = native_form
      card.created_at = form.attributes['CreationDate']
      card.legacy_id  = form.id

      card.save
    end

    def raw_data
      @raw_data ||= @form.data
    end

    def missing_data?
      @form.nil? || @form.data.nil?
    end

    private

    def corresponding_card
      if hit = ReportCard.find_by(legacy_id: form.id)
        corresponding = hit
      else
        attrs = {student: student, year: school_year}
        corresponding = ReportCard.where(attrs).first || ReportCard.new(attrs)
      end
      corresponding
    end

    def choose_parser
      case @form.attributes['FormNumber']
      when 'RC_Upper'
        @parser = Ischool::FormParsers::UpperParser.new(raw_data)
        @native_form = ReportCard::Form.find_by(renderer: 'upper')
      when 'RC_Primary'
        @parser = Ischool::FormParsers::PrimaryParser.new(raw_data)
        @native_form = ReportCard::Form.find_by(renderer: 'primary')
      when 'RC_K'
        @parser = Ischool::FormParsers::KinderParser.new(raw_data)
        @native_form = ReportCard::Form.find_by(renderer: 'kinder')
      when 'RC_TK'
        @parser = Ischool::FormParsers::TkParser.new(raw_data)
        @native_form = ReportCard::Form.find_by(renderer: 'tk')
      end
    end

    def school_year
      d = form.attributes['CreationDate']
      y = d.year
      case d.month
      when 1..6
        y - 1
      when 7
        d.day < 2 ? (d.year - 1) : d.year
      else
        y
      end
    end

  end
end
