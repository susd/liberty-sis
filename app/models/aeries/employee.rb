module Aeries
  class Employee < Base
    self.table_name = 'STF'
    # self.primary_key = 'ID'

    def hired_on
      hd && read_attribute_before_type_cast('hd').to_date
    end
  end
end
