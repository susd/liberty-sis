module ClassroomHelper

  def student_item(student)
    classes = [
      "list-group-item",
      "student_item-#{student.state}"
    ]

    link_to student.name, student_report_cards_path(student), class: classes.join(' ')
  end

  def classrooms_cache_key(classroom_relation, site = nil)
    max = classroom_relation.maximum(:updated_at).try(:to_i)
    ['classrooms', site.id, 'index', max].compact.join('/')
  end
end
