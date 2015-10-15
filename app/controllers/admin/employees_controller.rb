class Admin::EmployeesController < AdminController

  def index
    @employees = Employee.includes(:user).order(:last_name).page(params[:page]).per(50)
  end

  def search
    @employees = Employee.admin_search(params[:query]).limit(50)
    respond_to do |format|
      format.js
    end
  end

  def show
    set_employee
  end

  def edit
    set_employee
  end

  def update
    set_employee
    if @employee.update(employee_params)
      redirect_to admin_employees_path, notice: "Employee updated"
    else
      render :edit
    end
  end

  private

  def set_employee
    @employee = Employee.find params[:id]
  end

  def employee_params
    params.delete(:user_query)
    params.require(:employee).permit!
  end
end
