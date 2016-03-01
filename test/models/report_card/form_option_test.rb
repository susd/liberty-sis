# == Schema Information
#
# Table name: report_card_form_options
#
#  id                  :integer          not null, primary key
#  field_name          :string
#  field_type          :integer          default(0), not null
#  data                :jsonb            not null
#  report_card_form_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class ReportCard::FormOptionTest < ActiveSupport::TestCase
  test "parsing form submission" do
    opt = ReportCard::FormOption.new({
      field_name: "test_field",
      user_values: "item1\nitem2\nitem3"
      })

    opt.save
    opt.reload

    assert_includes opt.values, "item1"
  end

  test "ignoring extra lines" do
    opt = ReportCard::FormOption.new({
      field_name: "test_field",
      user_values: "item1\n\nitem3"
      })

    opt.save
    opt.reload

    assert_equal 2, opt.values.size
  end

  test "Chomping returns" do
    opt = ReportCard::FormOption.new({
      field_name: "test_field",
      user_values: "item1\r\nitem2\r\nitem3"
      })

    opt.save
    opt.reload

    refute_equal "item1\r", opt.values.first
  end
end
