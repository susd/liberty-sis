# == Schema Information
#
# Table name: employees
#
#  id              :integer          not null, primary key
#  type            :string
#  first_name      :string
#  last_name       :string
#  sex             :string
#  email           :string
#  birthdate       :date
#  hired_on        :date
#  years_edu       :integer          default(0), not null
#  years_district  :integer          default(0), not null
#  title           :string
#  state           :integer          default(0), not null
#  legacy_id       :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  import_details  :jsonb            not null
#  primary_site_id :integer
#

class Employee < ActiveRecord::Base
  enum state: {active: 0, inactive: 1}

  FILTER = /(\s|-|\'|\")/

  has_and_belongs_to_many :sites, -> { uniq }
  belongs_to :primary_site, foreign_key: 'primary_site_id', class_name: 'Site'
  belongs_to :user

  belongs_to :org_unit, class_name: "Gapps::OrgUnit", foreign_key: "gapps_org_unit_id"

  has_many :personas, as: :personable

  has_many :contacts, as: :contactable, dependent: :destroy
  has_many :addresses, -> { includes(:addressable) }, through: :contacts
  has_many :phones, -> { includes(:callable) }, through: :contacts

  before_save :set_email

  include PgSearch
  pg_search_scope :admin_search,
    against: [:email, :last_name, :first_name, :title],
    using: {tsearch: {prefix: true}, trigram: {only: [:last_name, :first_name]}},
    :ignoring => :accents

  def name
    "#{first_name} #{last_name}"
  end

  def persona_domain
    "saugususd.org"
  end

  def persona_name
    set_email
    email.split('@').first
  end

  def persona_email
    email
  end

  def persona_init_password
    pass = first_name.gsub(FILTER, '')[0..2]
    pass << lastest_name.gsub(FILTER, '')[0..2]
    pass << '001'
    pass
  end

  def guess_email
    if user.nil?
      attempt = "#{first_name[0]}#{lastest_name}@#{persona_domain}".downcase
      if Employee.where(email: attempt).where.not(id: self.id).exists?
        attempt = "#{first_name}#{lastest_name}@#{persona_domain}".downcase
      end
    else
      attempt = user.email
    end
    attempt.gsub(FILTER,'')
  end

  def lastest_name
    last_name.split('-').last
  end

  def set_email
    self.email = guess_email if attributes['email'].nil?
  end

  def dedup_sites
    @sites ||= sites
    sites = []
    sites = @sites.uniq
  end

  def add_site(new_site)
    unless sites.include? new_site
      sites << new_site
    end
  end

  def clean_sites
    if primary_site
      add_site(primary_site)
    end
    dedup_sites
  end

  def single_site?
    sites.count == 1
  end

  def multisite?
    sites.count > 1
  end

  def reimport!
    begin
      import_from_source
    rescue NameError
      return false
    end
  end

  private

  def import_from_source
    if import_details['import_class'].nil?
      false
    else
      klass = import_details['import_class'].constantize
      import_id = import_details['import_id']
      self.update(klass.find_by(id: import_id).to_teacher)
    end
  end
end
