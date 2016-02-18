# == Schema Information
#
# Table name: report_card_subjects
#
#  id                  :integer          not null, primary key
#  name                :string
#  spanish_name        :string
#  slug                :string
#  report_card_form_id :integer
#  position            :integer
#  major               :boolean
#  show_score          :boolean
#  show_effort         :boolean
#  show_level          :boolean
#  side_section        :boolean
#  positional_score    :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ReportCard::Subject < ActiveRecord::Base
  belongs_to :form, foreign_key: 'report_card_form_id'

  def title_for(lang = :english)
    lang == :english ? name : spanish_name
  end
end
