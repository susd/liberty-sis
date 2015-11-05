class EmployeeDispatcher
  attr_reader :employee
  include Rails.application.routes.url_helpers

  def initialize(employee)
    @employee = employee
  end

  def dispatch?
    true
  end

  def path
    # can view site classrooms?
    # no roles or rights?
  end
end
