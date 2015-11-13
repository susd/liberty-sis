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
    sites_path
  end

  def dispatched_role?
    employee.user.roles.any? do |r|
      ['principal', 'office'].include? r.name
    end
  end
end
