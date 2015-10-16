class Admin::RolesController < AdminController
  helper_method :permission_resources, :permission_abilities, :permission_levels

  def index
    @roles = Role.order(:name)
  end

  def new
    @role = Role.new
  end

  def edit
    set_role
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to admin_roles_path, notice: 'Role saved'
    else
      render :new
    end
  end

  def update
    set_role
    if @role.update(role_params)
      redirect_to admin_roles_path, notice: 'Role updated'
    else
      render :edit
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(*permitted)
  end

  def permitted
    arr = [:name]
    hsh = {form_permissions: {}}
    permission_resources.each do |res|
      hsh[:form_permissions][res.to_sym] = [:ability, :level]
    end
    arr << hsh
    arr
  end

  def permission_resources
    %w{sites employees classrooms students}
  end

  def permission_abilities
    %w{none view edit manage}
  end

  def permission_levels
    %w{none self own site all}
  end
end
