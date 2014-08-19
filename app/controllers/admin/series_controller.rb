class Admin::SeriesController < ApplicationController
  respond_to :html, :json
  before_filter :find_series, :only => [:edit, :update, :destroy]

  def index
    @series = Series.all
  end

  def new
    @series = Series.new
  end

  def create
    @series = Series.new(series_params)
    flash[:success] = "Successfully created series!" if @series.save
    respond_with @series, :location => admin_series_index_path
  end

  def edit
  end

  def update
    @series.update_attributes(series_params)
    respond_with @series, :location => admin_series_index_path
  end

  def destroy
    if @series.destroy
      flash[:success] = "Sucessfully deleted."
    else 
      flash[:error] = "Error in deleting series."
    end
    respond_with [:admin, @series]
  end

  private

  def series_params
    params.require(:series).permit(:name)
  end

  def find_series
    @series = Series.find(params[:id])
  end
end
