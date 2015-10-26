class Admin::EmployeesController < AdminController

  def index
    @employees = Employee.includes(:user).order(:last_name).page(params[:page]).per(50)
  end

  def search
    @employees = Employee.includes(:primary_site).admin_search(params[:query]).limit(50)
    respond_to do |format|
      format.js
    end
  end

  def show
    set_employee
  end

  def edit
    set_employee
    set_sites
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

  def set_sites
    @sites = Site.order(:code)
  end

  def employee_params
    params.delete(:user_query)
    if params[:teacher]
      params.require(:teacher).permit!
    else
      params.require(:employee).permit!
    end
  end
end
