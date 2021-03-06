module Aeries
  module AttendanceQueries
    extend ActiveSupport::Concern


    # Scopes

    def attendances
      Aeries::Attendance.where(sc: school_code, sn: student_number)
    end

    def absences
      attendances.where(al: %w{E I L M N R U})
    end

    def tardies
      attendances.where(al: %w{D L T})
    end



    # Absences

    def total_absences
      absences.count
    end

    def absences_for_period(period)
      absences.where(dt: period.starts_on..period.ends_on).count
    end

    def absences_this_period
      absences_for_period(ReportCard::GradingPeriod.current)
    end

    def absences_for_periods_this_year
      ReportCard::GradingPeriod.where(year: ReportCard::GradingPeriod.current.year).map{|p| absences_for_period(p)}
    end



    # Tardies

    def total_tardies
      tardies.count
    end

    def tardies_for_period(period)
      tardies.where(dt: period.starts_on..period.ends_on).count
    end

    def tardies_this_period
      tardies_for_period(ReportCard::GradingPeriod.current)
    end

    def tardies_for_periods_this_year
      ReportCard::GradingPeriod.where(year: ReportCard::GradingPeriod.current.year).map{|p| tardies_for_period(p)}
    end


    # Grouped

    def attendance_by_period
      ReportCard::GradingPeriod.where(year: ReportCard::GradingPeriod.current.year).inject({}) do |result, p|
        result.merge!(p.position => {absences: absences_for_period(p), tardies: tardies_for_period(p)})
      end
    end

    def attendance_by_type
      ReportCard::GradingPeriod.where(year: ReportCard::GradingPeriod.current.year).inject({}) do |result, p|
        result.merge!(tardies: tardies_for_periods_this_year, absences: absences_for_periods_this_year)
      end
    end

  end
end
