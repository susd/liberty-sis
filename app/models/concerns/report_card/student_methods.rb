module ReportCard::StudentMethods
  extend ActiveSupport::Concern

  included do
    has_many :report_cards
  end

  def current_report_card
    report_cards.find_by(year: ReportCard::GradingPeriod.school_year)
  end

  def current_or_new_report_card
    report_cards.find_or_create_by(year: ReportCard::GradingPeriod.school_year)
  end

  def latest_report_card
    report_cards.order(updated_at: :desc).first
  end
end
