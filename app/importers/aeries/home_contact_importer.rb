module Aeries
  class HomeContactImporter
    def self.for_student(native_student)
      if a = native_student.aeries_student
        new(a).import!
      end
    end

    attr_reader :student

    def initialize(aeries_student)
      @student = aeries_student
    end

    def import!
      SyncEvent.wrap(label: 'aeries:contact', syncable: native) do
        create_or_update_native_records
      end
    end

    def native
      @native ||= find_native
    end

    def native_student
      ::Student.find_by(["import_details @> ?", student.import_ids.to_json])
    end

    def find_native
      ::Contact.find_by([
        "import_details @> ?", {
          import_ids: [
            [student.attributes['id'], 'home']
          ]
        }.to_json
      ])
    end

    def exists?
      native.present?
    end

    def create_or_update_native_records
      if exists?
        native.update(contact_attrs)
      else
        @native = ::Contact.create(contact_attrs)
      end

      create_or_update_addresses
      create_or_update_phones
    end

    def create_or_update_addresses
      address_attrs.each do |addr_hsh|
        Aeries::AddressImporter.new(self, addr_hsh).import
      end
    end

    def create_or_update_phones
      phone_attrs.each do |ph_hsh|
        Aeries::PhoneImporter.new(self, ph_hsh).import
      end
    end

    def contact_attrs
      {
        contactable: native_student,
        first_name: student.attributes['fn'],
        last_name: student.attributes['ln'],
        email: student.attributes['pem'],
        label: 'home',
        relationship: 'home',
        position: 0,
        import_details: {source: 'aeries', import_class: self.class.to_s}.merge(student.import_ids)
      }
    end

    def address_attrs
      [
        {
          label: 'residence',
          street: student.attributes['rad'],
          city:   student.attributes['rcy'],
          state:  student.attributes['rst'],
          zip:    student.attributes['rzc']
        },
        {
          label: 'mailing',
          street: student.attributes['ad'],
          city:   student.attributes['cy'],
          state:  student.attributes['st'],
          zip:    student.attributes['zc']
        }
      ]
    end

    def phone_attrs
      [
        {label: 'mother_work',    original: student.attributes['mw']},
        {label: 'father_work',    original: student.attributes['fw']},
        {label: 'primary_phone',  original: student.attributes['tl']}
      ]
    end

  end
end
