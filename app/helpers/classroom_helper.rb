module ClassroomHelper

  def student_item(student)
    classes = [
      "list-group-item",
      "student_item-#{student.state}"
    ]

    link_to student.name, student_report_cards_path(student), class: classes.join(' ')
  end
end
