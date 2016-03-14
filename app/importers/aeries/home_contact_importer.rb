module Aeries
  class HomeContactImporter < ::ContactImporter
    def self.for_student(native_student)
      if a = native_student.aeries_student
        new(a).import!
      end
    end

    attr_reader :student

    def initialize(aeries_student)
      @student = aeries_student
    end

    def native_student
      ::Student.find_by(["import_details @> ?", student.import_ids.to_json])
    end

    def sync_label
      'aeries/contact'
    end

    def import_details
      {import_id: student.attributes['id'], import_class: self.class.to_s}
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
