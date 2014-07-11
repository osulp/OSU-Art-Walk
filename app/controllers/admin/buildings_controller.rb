class Admin::BuildingsController < AdminController
  respond_to :html, :json

  def index
    @buildings = Building.all
  end

  def new
    @building = Building.new
  end

  def create
    @building = Building.new(building_params)
    flash[:success] = "Successfully Created Building" if @building.save
    respond_with @building, :location => admin_buildings_path
  end

  def destroy
    if Building.find(params[:id]).destroy
      redirect_to admin_buildings_path, :flash => { :success => "Sucessfully deleted." }
    else 
      redirect_to admin_buildings_path, :flash => { :error => "Error in deleting art piece." }
    end
  end

  def edit
    @building = Building.find(params[:id])
  end

  def update
    @building = Building.find(params[:id])
    @building.update_attributes(building_params)
    respond_with @building, :location => admin_buildings_path
  end

  private

  def building_params
    params.require(:building).permit(:name, :description, :lat, :long)
  end
end
