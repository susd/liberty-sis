class Setting < ActiveRecord::Base
  def self.[](name)
    find_by(name: name)
  end
end
