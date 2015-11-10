# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  label            :text             default("mailing"), not null
#  street           :text
#  city             :text
#  state            :text             default("CA"), not null
#  country          :text             default("USA"), not null
#  zip              :integer          default(91355), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :integer
#  addressable_type :string
#

class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
end
