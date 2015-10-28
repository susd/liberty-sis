class Admin::UsersController < AdminController

  def index
    @users = User.includes(:employee).order(:last_name).page(params[:page]).per(50)
  end

  def search
    @users = User.includes(employee: :primary_site).admin_search(params[:query]).limit(10)

    respond_to do |format|
      format.json do
        render json: @users.map{|u| {id: u.id, value: "#{u.first_name} #{u.last_name} / #{u.email}"}}
      end
      format.js
    end
  end

  def show
    set_user
  end

  def edit
    set_user
    set_roles
  end

  def update
    set_user
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User updated'
    else
      set_roles
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_roles
    @roles = Role.order(:name)
  end

  def user_params
    params.require(:user).permit!
  end
end
