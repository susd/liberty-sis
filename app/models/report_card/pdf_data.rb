
class ReportCard::PdfData
  attr_reader :report_card

  def initialize(report_card)
    @report_card = report_card
  end

  def student_name
    lazy_lookup [
      report_card.fetch_data(['student_name']),
      report_card.student.try(:name),
      "Name Unknown"
    ]
  end

  def school_year
    report_card.fetch_data(['school_year']).try(:to_i) || SchoolYear.this_year
  end

  def school_name
    lazy_lookup [
      report_card.fetch_data(['school_name']),
      report_card.student.try(:site).try(:name),
      "School"
    ]
  end

  def home_lang
    @home_lang ||= begin
      if name = report_card.fetch_data(['home_lang'])
        Language.find_by(name: name)
      else
        lazy_lookup([
          report_card.student.try(:home_lang),
          Language.find_by(name: "English")
          ])
      end
    end
  end

  def home_locale
    home_lang.locale.to_sym || :en
  end

  def render_translated?
    home_lang.name != "English"
  end

  def subject_array(subject, columns, lang = :english)
    sub_arr = []

    if subject.major?
      sub_arr.unshift({
        content: subject.title_for(lang).mb_chars.upcase.to_s,
        font: PdfReportCard::DEFAULT_BOLD_FONT
        })
    else
      sub_arr.unshift(subject.title_for(lang))
    end

    (1..3).each do |p|
      if columns > 3
        sub_arr += p_score(get_score(subject, p))
        sub_arr << (subject.show_effort? ? checkmark_replace(get_effort(subject, p)) : "")
      else
        sub_arr << checkmark_replace(get_effort(subject, p))
      end
    end

    sub_arr
  end

  private

  def checkmark_replace(char)
    char == 'V' ? "✓" : char
  end

  def fetch(path = [])
    report_card.fetch_data(path)
  end

  def get_score(subject, period)
    fetch(['subjects', subject.id.to_s, 'periods', period.to_s, 'score'])
  end

  def get_effort(subject, period)
    fetch(['subjects', subject.id.to_s, 'periods', period.to_s, 'effort'])
  end

  def p_score(score)
    ReportCard::PositionalScore.new(score).to_a
  end

  def lazy_lookup(options = [])
    options.lazy.detect{|v| v.present? }
  end

end
