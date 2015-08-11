# == Schema Information
#
# Table name: classrooms
#
#  id             :integer          not null, primary key
#  name           :string
#  site_id        :integer
#  import_details :jsonb            default({}), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Classroom < ActiveRecord::Base
  belongs_to :site

  has_many :classroom_leaderships
  has_many :teachers, through: :classroom_leaderships, source: :employee

  has_many :classroom_memberships
  has_many :students, through: :classroom_memberships

  def reimport!
    begin
      import_from_source
    rescue NameError
      return false
    end
  end

  private

  def import_from_source
    if import_details['import_class'].nil?
      false
    else
      klass = import_details['import_class'].constantize
      code = import_details['import_school_code']
      teacher_num = import_details['import_teacher_num']
      klass.new(code, teacher_num).import!
    end
  end

end
