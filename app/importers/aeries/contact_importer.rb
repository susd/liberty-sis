module Aeries
  class ContactImporter

    def self.for_student(student)
      if a = student.aeries_student
        a.contacts.each do |c|
          new(c).import!
        end
      end
    end

    attr_reader :contact

    def initialize(aeries_contact)
      @contact = aeries_contact
    end

    def import!
      SyncEvent.wrap(label: 'aeries:contact', syncable: native) do
        if exists?
          update_native_records
        else
          create_native_records
        end
      end
    end

    def native
      @native ||= find_native
    end

    def find_native
      ::Contact.find_by(["import_details @> ?", contact.import_ids.to_json])
    end

    def exists?
      native.present?
    end

    def fresh?
      aeries_stamp = contact.dts
      last_import  = native.sync_events.maximum(:created_at)

      native.nil? || last_import.nil? || (aeries_stamp > last_import)
    end

    def update_native_records
      native.update(contact.contact_attrs)
      create_or_update_address
      create_or_update_phones
    end

    def create_native_records
      create_contact
      create_or_update_address
      create_or_update_phones
    end

    def create_contact
      ::Contact.create(contact.contact_attrs)
    end

    def create_or_update_address
      if native_addr = native.addresses.find_by(label: contact.relationship)
        native_addr.update(contact.address_attrs)
      else
        native_addr = native.addresses.create(contact.address_attrs)
      end
    end

    def create_or_update_phones
      contact.phone_attrs.each do |phone|
        if native_phone = native.phones.find_by(label: phone[:label])
          native_phone.update(phone)
        else
          native.phones.create(phone)
        end
      end
    end

  end
end
