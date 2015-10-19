module Ischool
  class ReportCardImporter

    def initialize(ischool_form, report_card)
      @form = ischool_form
      @card = report_card
      @data = Hash.new{|h,k| h[k] = Hash.new(&h.default_proc) }
      unless missing_data?
        choose_parser
      end
    end

    def import!
      return false if missing_data?

      parsed = @parser.parse!

      if @card.new_record?
        @card.data = parsed
      else
        @card.data.merge! parsed
      end

      @card.save
    end

    def raw_data
      @raw_data ||= @form.data
    end

    def missing_data?
      @form.nil? || @form.data.nil?
    end

    private

    def choose_parser
      case @form.attributes['FormNumber']
      when 'RC_Upper'
        @parser = Ischool::FormParsers::UpperParser.new(raw_data)
      when 'RC_Primary'
        @parser = Ischool::FormParsers::PrimaryParser.new(raw_data)
      when 'RC_K'
        @parser = Ischool::FormParsers::KinderParser.new(raw_data)
      when 'RC_TK'
        @parser = Ischool::FormParsers::TkParser.new(raw_data)
      end
    end

  end
end
