# == Schema Information
#
# Table name: classrooms
#
#  id                 :integer          not null, primary key
#  name               :string
#  site_id            :integer
#  import_details     :jsonb            default({}), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  primary_teacher_id :integer
#

class Classroom < ActiveRecord::Base
  belongs_to :site
  belongs_to :primary_teacher, class_name: 'Teacher'

  has_many :classroom_leaderships, dependent: :destroy
  has_many :teachers, through: :classroom_leaderships, source: :employee

  has_many :classroom_memberships, dependent: :destroy
  has_many :students, through: :classroom_memberships

  include ReportCard::ClassroomMethods

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
