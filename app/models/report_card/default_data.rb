class ReportCard::DefaultData
  attr_reader :report_card

  def self.save_defaults(report_card)
    data = new(report_card)
    data.save_defaults
  end

  def self.set_defaults(report_card)
    data = new(report_card)
    data.set_defaults
  end

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

  def teacher_name
    lazy_lookup [
      report_card.fetch_data(['teacher_name']),
      report_card.student.try(:homeroom).try(:primary_teacher).try(:name),
      "Teacher Name"
    ]
  end

  def principal_name
    lazy_lookup [
      report_card.fetch_data(['principal_name']),
      report_card.student.try(:site).try(:principal),
      "Principal Name"
    ]
  end

  def next_grade
    lazy_lookup [
      report_card.fetch_data(['next_grade']),
      report_card.student.try(:grade).try(:succ).try(:simple),
      0
    ]
  end

  def home_lang
    lazy_lookup [
      Language.find_by(name: report_card.fetch_data(['home_lang'])),
      report_card.student.try(:home_lang),
      Language.find_by(name: 'English')
    ]
  end

  def services
    report_card.fetch_data(['services']) || []
  end

  def set_defaults
    report_card.data.merge!(defaulted_attributes)
  end

  def save_defaults
    report_card.update(data: report_card.data.merge!(defaulted_attributes) )
  end

  def defaulted_attributes
    {
      'student_name'  => student_name,
      'school_year'   => school_year,
      'school_name'   => school_name
    }
  end

  private

  def lazy_lookup(options = [])
    options.lazy.detect{|v| v.present? }
  end
end
