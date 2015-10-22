# == Schema Information
#
# Table name: report_card_grading_periods
#
#  id         :integer          not null, primary key
#  starts_on  :date
#  ends_on    :date
#  position   :integer          default(0), not null
#  year       :integer          default(2015), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ReportCard::GradingPeriod < ActiveRecord::Base
  def self.create_year(start_dates, last_date)
    start_dates.each_with_index do |d, idx|
      p = new(starts_on: d)
      if start_dates[idx + 1]
        p.ends_on = start_dates[idx + 1] - 1.day
      else
        p.ends_on = last_date
      end
      p.year = start_dates.first.year
      p.position = idx
      p.save
    end
  end

  def self.current
    find_by("starts_on < :now AND ends_on > :now", {now: Time.now})
  end

  def self.previous
    order(starts_on: :desc).where("ends_on < ?", current.starts_on).first
  end

  def self.current_year
    where(year: school_year).order(:position)
  end

  def self.current_year_range
    (current_year.first.starts_on..current_year.last.ends_on)
  end

  def self.school_year
    now = Time.now
    case now.month
    when 1..6
      now.year - 1
    when 7
      now.day < 2 ? (now.year - 1) : now.year
    else
      now.year
    end
  end

  def range
    (starts_on..ends_on)
  end
end
