class Admin::MediaController < ApplicationController
  respond_to :html, :json
  before_filter :find_medium, :only => [:edit, :update, :destroy]

  def index
    @media = Medium.all
  end

  def new
    @medium = Medium.new
  end

  def create
    @medium = Medium.new(medium_params)
    flash[:success] = "Successfully created medium!" if @medium.save
    respond_with @medium, :location => admin_media_path
  end

  def edit
  end

  def update
    @medium.update_attributes(medium_params)
    respond_with @medium, :location => admin_media_path
  end

  def destroy
    if @medium.destroy
      flash[:success] = "Sucessfully deleted."
    else 
      flash[:error] = "Error in deleting medium."
    end
    respond_with [:admin, @medium]
  end

  private

  def medium_params
    params.require(:medium).permit(:medium)
  end

  def find_medium
    @medium = Medium.find(params[:id])
  end
end
