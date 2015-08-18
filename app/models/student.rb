# == Schema Information
#
# Table name: students
#
#  id                :integer          not null, primary key
#  first_name        :string
#  last_name         :string
#  middle_name       :string
#  sex               :string
#  birthdate         :datetime
#  site_id           :integer
#  grade_id          :integer
#  homeroom_id       :integer
#  home_lang_id      :integer
#  ethnicity_id      :integer
#  race_id           :integer
#  family_id         :integer
#  enrollment_status :integer          default(0), not null
#  flag              :integer          default(0), not null
#  legacy_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  import_details    :jsonb            default({}), not null
#

class Student < ActiveRecord::Base
  belongs_to :site
  belongs_to :grade
  belongs_to :home_lang, foreign_key: 'home_lang_id', class_name: 'Language'
  belongs_to :homeroom, foreign_key: 'homeroom_id', class_name: 'Classroom'

  has_many :classroom_memberships, dependent: :destroy
  has_many :classrooms, through: :classroom_memberships

  has_many :personas

  def name
    "#{first_name} #{last_name}"
  end

  def persona_name
    str = "#{first_name}"
    unless middle_name.blank?
      str << "#{middle_name[0]}"
    end
    str << "#{last_name}#{grad_year}"
    str.downcase.gsub(/(\s|-)/,'')
  end

  def persona_domain
    "#{site.abbr}.saugususd.org"
  end

  def persona_email
    "#{persona_name}@#{persona_domain}"
  end

  def persona_init_password
    "qwerty#{grad_year}"
  end

  def grad_year
    current_year = Time.now.year
    g_year = (12 - self.grade.position.floor) + current_year
    g_year.to_s[-2, 2]
  end

  def add_classroom(new_classroom)
    unless classrooms.include? new_classroom
      classrooms << new_classroom
    end
  end

end
