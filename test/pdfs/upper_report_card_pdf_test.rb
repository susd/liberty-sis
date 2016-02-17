require "test_helper"

class UpperReportCardPdfTest < ActiveSupport::TestCase

  def setup
    @report_card = students(:cindy).report_cards.new(
      form: report_card_forms(:primary),
      data: {
      name: "Cindy",
      school: "Hogwarts",
      teacher: "Ashley Doe",
      principal: "Mrs. Featherbottom",
      subjects: {
        "1"=>{
          "periods"=>{
            "1"=>{"score"=>"", "effort"=>""},
            "2"=>{"score"=>"", "effort"=>""},
            "3"=>{"score"=>"", "effort"=>""}
          }
        }
      }
      })
    @card_pdf = UpperReportCardPdf.new(@report_card)
  end

  test "Rendering report card" do
    skip "Too much setup currently required"
    output_pdf("upper_card", @card_pdf.render)
  end

  private

  def output_pdf(name, rendered_doc)
    File.open(@path.join("#{name}.pdf"), 'wb') do |f|
      f.puts rendered_doc
    end
  end
end
