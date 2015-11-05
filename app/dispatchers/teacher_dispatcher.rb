class TeacherDispatcher
  attr_reader :employee
  include Rails.application.routes.url_helpers

  def initialize(employee)
    @employee = employee
  end

  def dispatch?
    employee.is_a?(Teacher) && employee.classrooms.any?
  end

  def path
    if dispatch?
      teacher_path
    end
  end

  private

  def teacher_path
    case
    when employee.user.can_generally?(:view, :site, :classrooms)
      classrooms_path
    when employee.classrooms.count > 1
      classrooms_path
    when employee.primary_classroom
      classroom_path(employee.primary_classroom)
    else
      classroom_path(employee.classrooms.first)
    end
  end
end
