class Admin::BuildingsController < AdminController
  respond_to :html, :json
  before_filter :find_building, :only => [:edit, :update, :destroy]

  def index
    @buildings = Building.all
    respond_with(@buildings)
  end

  def edit
  end

  def update
    @building.update_attributes(building_params)
    respond_with @building, :location => admin_buildings_path
  end

  def destroy
    if @building.destroy
      flash[:success] = "Succesfully deleted."
    else
      flash[:error] = "Error in deleting building"
    end
    respond_with [:admin, @building]
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(building_params)
    flash[:success] = "Successfully Created Building" if @building.save
    respond_with @building, :location => admin_buildings_path
  end

  private

  def find_building
    @building = Building.find(params[:id])
  end

  def building_params
    params.require(:building).permit(:name, :description, :lat, :long)
  end
end
