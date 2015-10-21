module ReportCard::AttendanceQueries
  extend ActiveSupport::Concern

  def tardies_in_range(range)
    attendances.tardies.in_range(range).count
  end

  def absences_in_range(range)
    attendances.absences.in_range(range).count
  end

  def tardies_for_periods_this_year
    ReportCard::GradingPeriod.current_year.map{|p| tardies_in_range(p.range) }
  end

  def absences_for_periods_this_year
    ReportCard::GradingPeriod.current_year.map{|p| absences_in_range(p.range) }
  end

  def attendance_by_period
    ReportCard::GradingPeriod.current_year.inject({}) do |result, p|
      result.merge!({
        p.position => {
          absences: absences_in_range(p.range),
          tardies: tardies_in_range(p.range)
        }
      })
    end
  end

  def attendance_by_type
    ReportCard::GradingPeriod.current_year.inject({}) do |result, p|
      result.merge!(tardies: tardies_for_periods_this_year, absences: absences_for_periods_this_year)
    end
  end
end
