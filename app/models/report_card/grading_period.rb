class ReportCard::GradingPeriod < ActiveRecord::Base
  def self.current
    find_by("starts_on < :now AND ends_on > :now", {now: Time.now})
  end

  def self.previous
    order(starts_on: :desc).where("ends_on < ?", current.starts_on).first
  end

  def self.current_year
    year = current.year
    where(year: year).order(:position)
  end

  def self.current_year_range
    (current_year.first.starts_on..current_year.last.ends_on)
  end

  def range
    (starts_on..ends_on)
  end
end
