class EmployeeDispatcher
  attr_reader :employee
  include Rails.application.routes.url_helpers

  def initialize(employee)
    @employee = employee
  end

  def dispatch?
    dispatched_role?
  end

  def path
    if employee.sites.count > 1
      sites_path
    else
      classrooms_path
    end
  end

  def dispatched_role?
    #FIXME: Remove magic
    employee.user.roles.any? do |r|
      ['principal', 'office', 'sst-teacher'].include? r.name
    end
  end
end
