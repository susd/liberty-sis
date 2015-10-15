class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.includes(:employee).order(:last_name).page(params[:page]).per(50)
  end

  def search
    @users = User.admin_search(params[:term]).limit(10)

    respond_to do |format|
      format.json do
        render json: @users.map{|u| {id: u.id, value: "#{u.first_name} #{u.last_name} / #{u.email}"}}
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User updated'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
