# == Schema Information
#
# Table name: contacts
#
#  id               :integer          not null, primary key
#  contactable_id   :integer
#  contactable_type :string
#  label            :string
#  first_name       :string
#  last_name        :string
#  email            :string
#  note             :text
#  import_details   :jsonb
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Contact < ActiveRecord::Base
  belongs_to :contactable, polymorphic: true
  has_many :addresses, as: :addressable
  has_many :phones, as: :callable
end
