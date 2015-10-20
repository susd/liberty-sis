module ReportCardsHelper
  def delete_report_card_link(student, report_card)
    options = {
      class: 'btn btn-danger',
      method: :delete,
      data: {
        confirm: 'Are you sure? This cannot be undone.'
      }
    }
    link_to( 'Delete this report card', student_report_card_path(student, report_card), options )
  end

  def cached_pdf_button(student, report_card)
    options = {
      class: 'btn btn-default btn-block'
    }
    link_to( 'View PDF', show_cached_student_report_card_path(student, report_card, format: :pdf), options )
  end
end
