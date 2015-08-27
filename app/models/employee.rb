# == Schema Information
#
# Table name: employees
#
#  id             :integer          not null, primary key
#  type           :string
#  first_name     :string
#  last_name      :string
#  sex            :string
#  email          :string
#  birthdate      :date
#  hired_on       :date
#  years_edu      :integer          default(0), not null
#  years_district :integer          default(0), not null
#  title          :string
#  status         :integer          default(0), not null
#  legacy_id      :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  import_details :jsonb            default({}), not null
#

class Employee < ActiveRecord::Base
  has_and_belongs_to_many :sites
  belongs_to :user
  has_many :personas, as: :personable

  before_save :set_email

  def email
    attributes['email'] || guess_email
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
    pass = (last_name[0..4].gsub(/(\s|-|\'|\")/, '')).reverse
    pass << 'susd'
    pass << '001'
    pass
  end

  # FIXME: This is great idea, if there were any emails in the table to begin with!
  def guess_email
    if user.nil?
      attempt = "#{first_name[0]}#{lastest_name}@#{persona_domain}".downcase
      if Employee.where(email: attempt).where.not(id: self.id).exists?
        attempt = "#{first_name}#{lastest_name}@#{persona_domain}".downcase
      end
    else
      attempt = user.email
    end
    attempt.gsub(/(\s|-|\'|\")/,'')
  end

  def lastest_name
    last_name.split('-').last
  end

  def set_email
    self.email = guess_email if attributes['email'].nil?
  end
end
