# == Schema Information
#
# Table name: report_card_form_options
#
#  id                  :integer          not null, primary key
#  field_name          :string
#  field_type          :integer          default(0), not null
#  data                :jsonb            not null
#  report_card_form_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ReportCard::FormOption < ActiveRecord::Base
  belongs_to :form, foreign_key: :report_card_form

  def user_values=(str)
    data[:values] = str.split("\n").delete_if(&:blank?)
  end

  def values
    fetch_data(['values'])
  end

  def fetch_data(keys = [])
    keys.inject(self.data){|data, key| data && data[key] }
  end
end
