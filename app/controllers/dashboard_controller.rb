class DashboardController < ApplicationController
  def index
    if current_user.employee && current_user.employee.type == 'Teacher'
      redirect_to classrooms_path
    end
    authorize_signed_in_user!
  end
end
