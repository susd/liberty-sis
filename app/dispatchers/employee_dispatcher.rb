class EmployeeDispatcher
  attr_reader :employee
  include Rails.application.routes.url_helpers

  def initialize(employee)
    @employee = employee
  end

  def dispatch?
    employee.type == 'Teacher'
  end

  def path
    if dispatch?
      teacher_path
    end
  end

  private

  def teacher_path
    case
    when employee.classrooms.count > 1
      classrooms_path
    else
      classroom_path(employee.primary_classroom)
    end
  end
end
