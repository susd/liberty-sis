class SchoolYear
  def self.this_year
    year_for(Time.now)
  end

  def self.year_for(date)
    case date.month
    when 1..6
      date.year - 1
    when 7
      date.day < 2 ? (date.year - 1) : date.year
    else
      date.year
    end
  end

  def self.this_year_range
    this_year..(this_year + 1)
  end
end
