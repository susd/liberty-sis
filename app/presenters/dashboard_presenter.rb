class DashboardPresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def user_count
    User.count
  end

  def teacher_count
    Teacher.count
  end

  def rc_year_count
    ReportCard.where(year: SchoolYear.this_year).count
  end

  def rc_period_count
    ReportCard.where(
      created_at: ReportCard::GradingPeriod.current_year_range,
      year: SchoolYear.this_year
      ).count
  end

  def show_adoption?
    user.roles.any? do |r|
      ['admin', 'tosa'].include? r.name
    end
  end

  def show_student_search?
    user.roles.any? do |r|
      ['admin', 'tosa'].include? r.name
    end
  end

end
