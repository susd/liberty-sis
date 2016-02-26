
class ReportCard::PdfData
  attr_reader :report_card

  delegate :teacher_name, :principal_name, :home_lang, :next_grade, to: :defaulted

  def initialize(report_card)
    @report_card = report_card
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

  def defaulted
    @defaulted ||= ReportCard::DefaultData.new(report_card)
  end

end
