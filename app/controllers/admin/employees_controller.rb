class Admin::EmployeesController < AdminController
  before_action :set_employee, except: [:index, :new, :delete]

  def index
    @employees = Employee.includes(:user).order(:last_name).page(params[:page]).per(50)
  end

  def show
  end

  def edit
  end

  def update
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
