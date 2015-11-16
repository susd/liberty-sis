module Aeries
  class Contact < Base
    self.table_name = "CON"
    self.primary_keys = [:pid, :sq]

    def student
      Aeries::Student.active.find_by(id: self.pid)
    end

    def import_ids
      {import_ids: self.id}
    end

    def contact_attrs
      {
        contactable: find_contactable,
        first_name: first_name,
        last_name: last_name,
        email: attributes['em'],
        note: attributes['me'],
        relationship: relationship,
        import_details: {source: 'aeries', import_class: self.class.to_s}.merge(import_ids)
      }
    end

    def address_attrs
      {
        label: relationship,
        street: attributes['ad'],
        street2: attributes['ad2'],
        city: attributes['cy'],
        state: attributes['st'],
        zip: zip_code,
        name: attributes['nm']
      }
    end

    def phone_attrs
      phone_map.map do |k, label|
        {label: label, original: attributes[k]}
      end
    end

    def relationship
      # map Aeries code to string
      relationship_map[attributes['rl']]
    end

    def find_contactable
      ::Student.active.find_by(["import_details @> ?", {import_id: attributes['pid']}.to_json])
    end

    def zip_code
      attributes['zc'].blank? ? 0 : attributes['zc']
    end

    def first_name
      # attributes['fn'] or attempt to pull from mailing name
    end

    def last_name
      # attributes['ln'] or attempt to pull from mailing name
    end

    private

    def relationship_map
      {
        "10" => "Mother",
        "11" => "Father",
        "12" => "Stepfather",
        "13" => "Stepmother",
        "14" => "Foster Father",
        "15" => "Foster Mother",
        "16" => "Grandfather",
        "17" => "Grandmother",
        "18" => "Uncle",
        "19" => "Aunt",
        "20" => "Family Member",
        "21" => "Court Appointed Guardian",
        "22" => "Caregiver",
        "23" => "Emergency Contact",
        "24" => "Surrogate parent (for IEP)",
        "25" => "Agency Representative",
        "26" => "Doctor",
        "27" => "Other Relative",
        "28" => "Other Relationship"
      }
    end

    def phone_map
      {
        'tl' => 'Home',
        'wp' => 'Work',
        'cp' => 'Mobile'
      }
    end

  end
end
