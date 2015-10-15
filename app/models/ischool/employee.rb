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
      primary_site: Site.find_by(abbr: employee.attributes['SchoolID'].downcase),
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
