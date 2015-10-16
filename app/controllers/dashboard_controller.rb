class DashboardController < ApplicationController
  def index
    if dispatch?
      redirect_to employee_path
    end
    authorize_signed_in_user!
  end

  private

  def employee_path
    dispatcher.path
  end

  def dispatch?
    current_employee && dispatcher.dispatch?
  end

  def dispatcher
    @dispatcher ||= EmployeeDispatcher.new(current_employee)
  end
end
