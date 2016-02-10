class ContactImporter
  def self.import_each(foreign_relation)
    foreign_relation.find_each do |record|
      new(record).import
    end
  end

  def initialize(importable_record)
    @record = importable_record
  end

  def import
    SyncEvent.wrap(label: sync_label) do |evnt|
      create_or_update_native_records
    end
  end

  def sync_label
    'contact'
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
      ::AddressImporter.new(self, addr_hsh).import
    end
  end

  def create_or_update_phones
    phone_attrs.each do |ph_hsh|
      ::PhoneImporter.new(self, ph_hsh).import
    end
  end

  def contact_attrs
    raise "Not Implemented!"
  end

  def address_attrs
    raise "Not Implemented!"
  end

  def phone_attrs
    raise "Not Implemented!"
  end

  def native
    @native ||= ::Contact.find_by(["import_details @> ?", import_details.to_json])
  end

  def import_details
    raise "Not Implemented!"
  end

  def exists?
    native.present?
  end

end
