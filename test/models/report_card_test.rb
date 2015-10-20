# == Schema Information
#
# Table name: report_cards
#
#  id                  :integer          not null, primary key
#  student_id          :integer
#  report_card_form_id :integer
#  data                :jsonb
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  import_details      :jsonb            default({}), not null
#  year                :integer          default(2015), not null
#  employee_id         :integer
#

require 'test_helper'

class ReportCardTest < ActiveSupport::TestCase
  def setup
    @student = students(:long_name)
    @report_card = report_cards(:long_names_card)
  end

  test "student id partition" do
    assert_equal %w{123 456 789}, @report_card.student_id_partition
  end

  test "Cache relative directory" do
    assert_equal "/students/123/456/789", @report_card.cache_rel_dir
  end

  test "Cache file name" do
    # "#{student.name.parameterize}-progress_card_#{updated_at.strftime('%Y%m%d-%H%M')}.pdf"
    assert_equal "#{@student.name.parameterize}-progress_card_20151020-0500.pdf", @report_card.cache_name
  end

  test "Cache absolute dir" do
    expected = ReportCard.cache_dir.join('students', *@report_card.student_id_partition).to_s
    assert_equal expected, @report_card.cache_dir
  end

  test "Cache full path" do
    expected = ReportCard.cache_dir.join('students', *@report_card.student_id_partition, "#{@student.name.parameterize}-progress_card_20151020-0500.pdf").to_s
    assert_equal expected, @report_card.cache_path
  end
end
