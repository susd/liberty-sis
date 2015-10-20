module Aeries
  module StudentConvenience
    extend ActiveSupport::Concern

    def aeries_student
      Aeries::Student.active.find_by(id: self.import_details['import_id'])
    end
  end
end
