class Admin::SettingsController < AdminController
  respond_to :html, :json
  before_filter :find_setting, :only => [:edit, :update, :destroy]

  def index
    @setting = Setting.all
  end

  def new
    @setting = Setting.new
  end

  def create
    @setting = Setting.new(setting_params)
    flash[:success] = "Successfully Created Setting" if @setting.save
    respond_with @setting, :location => admin_settings_path
  end

  def edit
  end

  def update
    flash[:success] = "Successfully Updated Setting" if @setting.update_attributes(setting_params)
    respond_with @setting, :location => admin_settings_path
  end

  def destroy
    flash[:success] = "Successfully Deleted Setting" if @setting.destroy
    redirect_to admin_settings_path
  end


  private

  def setting_params
    params.require(:setting).permit(:copyright, :email, :about)
  end

  def find_setting
    @setting = Setting.find(params[:id])
  end

end
