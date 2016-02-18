class ReportCard::PositionalScore
  attr_reader :periods, :score

  def initialize(score, periods: 3)
    @score = score
    @periods = periods
  end

  def to_a
    (0..(periods - 1)).map do |i|
      i.to_s == score.to_s ? "✓" : ""
    end
  end
end
