# == Schema Information
#
# Table name: Faculty
#
#  FacultyID      :integer          not null, primary key
#  Address        :string(255)
#  AddressRelease :string(1)
#  Birthdate      :date
#  City           :string(30)
#  Email          :string(60)
#  FacultyType    :string(10)
#  FirstName      :string(30)
#  Gender         :string(1)        default("")
#  LastName       :string(30)
#  MiddleName     :string(30)
#  Notes          :string(255)
#  Password       :string(32)
#  Phone1         :string(20)
#  Phone2         :string(20)
#  PhoneRelease   :string(1)
#  SchoolID       :string(6)
#  SecurityGroups :string(255)
#  SSN            :string(11)
#  State          :string(6)
#  Status         :integer
#  Title          :string(45)
#  UserID         :string(20)
#  Zip            :string(10)
#  EID            :string(15)
#

class Ischool::Employee < Ischool::Base
  self.primary_key = 'FacultyID'
  self.table_name = 'Faculty'

  def self.staff
    where("FacultyType = ?", "Staff")
  end

  def self.active
    where("Status = ?", 1)
  end

  def to_employee
    {
      first_name: attributes['FirstName'],
      last_name: attributes['LastName'],
      sex: attributes['Gender'],
      email: email,
      birthdate: attributes['Birthdate'],
      title: attributes['Title'],
      primary_site: Site.find_by(abbr: attributes['SchoolID'].downcase),
      import_details: import_details
    }
  end

  def email
    attributes['Email'].gsub(/saugus\.k12\.ca\.us/i, 'saugususd.org')
  end

  def import_details
    {
      source: 'ischool',
      import_class: self.class.to_s,
      import_id: self.id
    }
  end
end
