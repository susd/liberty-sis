class DashboardPresenter

  def user_count
    User.count
  end

  def teacher_count
    Teacher.count
  end

  def rc_year_count
    ReportCard.where(year: ReportCard::GradingPeriod.school_year).count
  end

  def rc_period_count
    ReportCard.where(
      created_at: ReportCard::GradingPeriod.current_year_range,
      year: ReportCard::GradingPeriod.school_year
      ).count
  end
end
