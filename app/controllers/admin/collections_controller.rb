class Admin::CollectionsController < ApplicationController
  respond_to :html, :json
  before_filter :find_collection, :only => [:edit, :update, :destroy]

  def index
    @collections = Collection.all
  end

  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(collection_params)
    flash[:success] = "Successfully created collection!" if @collection.save
    respond_with @collection, :location => admin_collections_path
  end

  def edit
  end

  def update
    @collection.update_attributes(collection_params)
    respond_with @collection, :location => admin_collections_path
  end

  def destroy
    if @collection.destroy
      flash[:success] = "Sucessfully deleted."
    else 
      flash[:error] = "Error in deleting collection."
    end
    respond_with [:admin, @collection]
  end

  private

  def collection_params
    params.require(:collection).permit(:name, :collection_url)
  end

  def find_collection
    @collection = Collection.find(params[:id])
  end
end
