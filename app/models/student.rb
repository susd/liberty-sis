# == Schema Information
#
# Table name: students
#
#  id                :integer          not null, primary key
#  first_name        :string
#  last_name         :string
#  middle_name       :string
#  sex               :string
#  birthdate         :date
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
#  state             :integer          default(0), not null
#

class Student < ActiveRecord::Base
  include ReportCard::StudentMethods
  include ReportCard::AttendanceQueries
  include Aeries::StudentConvenience
  include PgSearch

  enum state: {pending: 0, active: 1, inactive: 2}

  include AASM

  NAME_LENGTH = 5

  belongs_to :site
  belongs_to :grade
  belongs_to :home_lang, foreign_key: 'home_lang_id', class_name: 'Language'
  belongs_to :homeroom, foreign_key: 'homeroom_id', class_name: 'Classroom'

  has_many :attendances

  has_many :classroom_memberships, dependent: :destroy
  has_many :classrooms, through: :classroom_memberships

  has_many :contacts, as: :contactable, dependent: :destroy
  has_many :addresses, -> { includes(:addressable) }, through: :contacts
  has_many :phones, -> { includes(:callable) }, through: :contacts

  has_many :enrollments
  has_many :inactive_sites, -> { where(enrollments: {state: 0}) }, source: :site, through: :enrollments

  has_many :personas, as: :personable, dependent: :destroy
  has_many :sync_events, as: :syncable, dependent: :nullify

  aasm column: :state, enum: true do
    state :pending, initial: true
    state :active
    state :inactive

    event :activate do
      transitions to: :active
    end

    event :deactivate do
      transitions to: :inactive
    end
  end

  pg_search_scope :admin_search,
    against: [:first_name, :middle_name, :last_name],
    using: { tsearch: {prefix: true}, trigram: {only: [:last_name, :first_name]} },
    :ignoring => :accents

  def name
    "#{first_name} #{last_name}"
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def persona_name
    str = "#{first_name[0..NAME_LENGTH]}"
    unless middle_name.blank?
      str << "#{middle_name[0]}"
    end
    str << "#{last_name}#{grad_year}"
    str.downcase.gsub(/(\s|-|\'|\")/,'')
  end

  def persona_domain
    "saugususd.org"
  end

  def persona_email
    "#{persona_name}@#{persona_domain}"
  end

  def persona_init_password
    "qwerty#{grad_year}"
  end

  def grad_year
    now = Time.now
    if now.month < 7
      current_year = now.year
    else
      current_year = now.year + 1
    end
    g_year = (12 - self.grade.position.floor) + current_year
    g_year.to_s[-2, 2]
  end

  def add_classroom(new_classroom)
    unless classrooms.include? new_classroom
      classrooms << new_classroom
    end
  end

  def reset_classrooms
    classroom_memberships.destroy_all
    add_classroom(homeroom)
  end

  def reimport!
    begin
      import_from_source
    rescue NameError
      return false
    end
  end

  private

  #FIXME: too dependent on knowing how importer works
  def import_from_source
    if import_details['import_class'].nil?
      false
    else
      klass = import_details['import_class'].constantize
      import_id = import_details['import_id']
      self.update(klass.find_by(id: import_id).to_student)
    end
  end

end
