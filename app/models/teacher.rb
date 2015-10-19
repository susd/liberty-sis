# == Schema Information
#
# Table name: employees
#
#  id              :integer          not null, primary key
#  type            :string
#  first_name      :string
#  last_name       :string
#  sex             :string
#  email           :string
#  birthdate       :date
#  hired_on        :date
#  years_edu       :integer          default(0), not null
#  years_district  :integer          default(0), not null
#  title           :string
#  state           :integer          default(0), not null
#  legacy_id       :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  import_details  :jsonb            default({}), not null
#  primary_site_id :integer
#

class Teacher < Employee
  has_many :classroom_leaderships, foreign_key: 'employee_id'
  has_many :classrooms, through: :classroom_leaderships
  has_many :students, through: :classrooms

  has_one :primary_classroom, class_name: 'Classroom', foreign_key: 'primary_teacher_id'

  def add_classroom(new_classroom)
    unless classrooms.include? new_classroom
      classrooms << new_classroom
    end
  end
end
