class PhoneImporter
  def initialize(contact_importer, phone_attrs)
    @contact_importer = contact_importer
    @phone_attrs = phone_attrs
  end

  def import
    return false unless importable?

    if exists?
      native.update(@phone_attrs)
    else
      native_contact.phones.create(@phone_attrs)
    end
  end

  def native_contact
    @contact_importer.native
  end

  def native
    @native_phone ||= find_native_phone
  end

  def exists?
    native.present?
  end

  def importable?
    !@phone_attrs[:original].blank?
  end

  private

  def find_native_phone
    native_contact.phones.find_by(label: @phone_attrs[:label])
  end
end
