# == Schema Information
#
# Table name: personas
#
#  id           :integer          not null, primary key
#  student_id   :integer
#  handler      :string
#  username     :string
#  password     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  state        :integer          default(0), not null
#  service_id   :string
#  service_data :jsonb            default({}), not null
#  synced_at    :datetime
#

class Persona < ActiveRecord::Base
  enum state: {pending: 0, active: 1, errored: 2, disabled: 3}
  include AASM

  belongs_to :student

  aasm column: :state, enum: true do
    state :pending, initial: true
    state :active
    state :errored
    state :disabled

    event :activate do
      transitions to: :active
    end

    event :disable do
      transitions to: :disabled
    end
  end
  
end
