class ViewableEmployeesQuery
  attr_reader :user, :employee, :relation

  def initialize(current_user)
    @user = current_user
    @employee = current_user.employee
  end

  def employees
    case
    when user.can_generally?(:view, :all, :employees)
      Employee.all
    when user.can_generally?(:view, :site, :employees)
      Employee.joins(:sites).where(sites: {id: @employee.sites.pluck(:id)}).uniq
    else
      Employee.where(id: @employee.id)
    end
  end
end
