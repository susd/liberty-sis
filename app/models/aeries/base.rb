module Aeries
  class Base < ActiveRecord::Base
    self.abstract_class = true
    self.default_timezone = :local
    establish_connection "aeries_#{Rails.env}".to_sym
  end
end
