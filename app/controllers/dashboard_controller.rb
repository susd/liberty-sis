class DashboardController < ApplicationController
  def index

    # TODO: send different users to different dashboards?
    if dispatch?
      redirect_to employee_path
    end
    @dash = DashboardPresenter.new
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
    @dispatcher ||= TeacherDispatcher.new(current_employee)
  end
end
