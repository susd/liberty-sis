class Admin::EmployeesController < AdminController
  helper_method :submit_path_for

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

  def new
    @employee = Employee.new
    set_sites
  end

  def edit
    set_employee
    set_sites
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to admin_employee_path(@employee), notice: "Employee created."
    else
      set_sites
      render :new
    end
  end

  def update
    set_employee
    if @employee.update(employee_params)
      redirect_to admin_employees_path, notice: "Employee updated"
    else
      set_sites
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

  def submit_path_for(employee)
    if employee.new_record?
      admin_employees_path
    else
      admin_employee_path(employee)
    end
  end
end
