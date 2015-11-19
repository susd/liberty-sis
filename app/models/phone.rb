# == Schema Information
#
# Table name: phones
#
#  id            :integer          not null, primary key
#  label         :string
#  original      :string
#  callable_id   :integer
#  callable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  normal        :text
#

class Phone < ActiveRecord::Base
  belongs_to :callable, polymorphic: true, touch: true

  before_save :update_normal

  def number
    original.gsub(/\D/, '').to_i
  end

  def to_s
    case normal.size
    when 7
      "#{normal[0..2]}-#{normal[3..6]}"
    when 10
      "(#{normal[0..2]}) #{normal[3..5]}-#{normal[6..9]}"
    else
      self.original
    end
  end

  def update_normal
    if original_changed?
      self.normal = number
    end
  end

end
