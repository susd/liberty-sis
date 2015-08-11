class Ischool::Base < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "ischool_#{Rails.env}".to_sym
end