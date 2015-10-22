# == Schema Information
#
# Table name: attendances
#
#  id             :integer          not null, primary key
#  student_id     :integer
#  date           :date
#  day            :integer          default(0), not null
#  kind           :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  import_details :jsonb            default({}), not null
#

class Attendance < ActiveRecord::Base
  belongs_to :student
  
  has_many :sync_events, as: :syncable, dependent: :nullify

  enum kind: {present: 0, tardy: 1, absent: 2}

  def self.absences
    where(kind: 2)
  end

  def self.tardies
    where(kind: 1)
  end

  def self.in_range(range)
    where(date: range)
  end
end
