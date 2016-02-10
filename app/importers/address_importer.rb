class AddressImporter
  DEFAULT_ZIP = 91355

  def initialize(contact_importer, address_attrs)
    @contact_importer = contact_importer
    @address_attrs = address_attrs
  end

  def import
    if exists?
      native.update(attrs)
    else
      native_contact.addresses.create(attrs)
    end
  end

  def attrs
    @attrs ||= begin
      if @address_attrs[:zip].blank?
        @address_attrs[:zip] = DEFAULT_ZIP
      end
      @address_attrs
    end
  end

  def native_contact
    @contact_importer.native
  end

  def native
    @native_address ||= find_native_address
  end

  def exists?
    native.present?
  end

  private

  def find_native_address
    native_contact.addresses.find_by(label: attrs[:label])
  end
end
