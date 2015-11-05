class DashboardController < ApplicationController
  def index
    # TODO: send different users to different dashboards?
    if dispatch?
      redirect_to teacher_path
    end
    @dash = DashboardPresenter.new(current_user)
    authorize_signed_in_user!
  end

  private

  def teacher_path
    dispatcher.path
  end

  def dispatch?
    current_employee && dispatcher.dispatch?
  end

  def dispatcher
    # @dispatcher ||= TeacherDispatcher.new(current_employee)
    klass = "#{current_employee.class.to_s.titlecase}Dispatcher".safe_constantize || EmployeeDispatcher
    @dispatcher ||= klass.new(current_employee)
  end
end
