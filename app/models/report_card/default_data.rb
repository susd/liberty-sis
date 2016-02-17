
class ReportCard::DefaultData
  attr_reader :report_card

  def initialize(report_card)
    @report_card = report_card
  end

  def student_name
    [
      report_card.fetch_data(['student_name']),
      report_card.student.try(:name),
      "Name Unknown"
    ].lazy.detect{|v| v.present? }
  end

  def school_year
    report_card.fetch_data(['school_year']).try(:to_i) || SchoolYear.this_year
  end
end
