class Admin::UsersController < AdminController
  respond_to :html, :json

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if current_user.id == @user.id
      flash[:error] = "You can't change your own status."
      respond_with @user, :location => admin_users_path
    else
      @user.update_attributes(user_params)
      respond_with @user, :location => admin_users_path
    end
  end

  def show
  end

  private 

    def user_params
      params.require(:user).permit(:email, :admin)
    end

end
