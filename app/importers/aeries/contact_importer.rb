module Aeries
  class ContactImporter
    attr_reader :contact

    def initialize(aeries_contact)
      @contact = aeries_contact
    end

    def import!
      SyncEvent.wrap(label: 'aeries:contact') do
        if exists?
          native.update(contact.to_native)
        else
          @native = ::Contact.create(contact.to_native)
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


  end
end
