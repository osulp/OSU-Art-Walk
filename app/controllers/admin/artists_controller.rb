class Admin::ArtistsController < AdminController
  respond_to :html, :json

  def index
    @artists = Artist.all
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    @artist.update_attributes(artist_params)
    respond_with @artist, :location => admin_artists_path
  end

  def destroy
    if Artist.find(params[:id]).destroy
      redirect_to admin_artists_path, :flash => { :success => "Sucessfully deleted." }
    else 
      redirect_to admin_artists_path, :flash => { :error => "Error in deleting art piece." }
    end
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    flash[:success] = "Successfully created artist!" if @artist.save
    respond_with @artist, :location => admin_artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :bio, :website, :birthdate, :deathdate)
  end
end
