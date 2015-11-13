# == Schema Information
#
# Table name: phones
#
#  id            :integer          not null, primary key
#  label         :string
#  original      :string
#  number        :integer
#  callable_id   :integer
#  callable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Phone < ActiveRecord::Base
  belongs_to :callable, polymorphic: true

  def set_number
    self.number = original.gsub(/\D/, '')
  end

  def normalize
    case number.size
    when 7
      "#{number[0..2]}-#{number[3..6]}"
    when 10
      "(#{number[0..2]}) #{number[3..5]}-#{number[6..9]}"
    else
      self.original
    end
  end
end
