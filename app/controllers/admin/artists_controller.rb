class Admin::ArtistsController < AdminController
  respond_to :html, :json
  before_filter :find_artist, :only => [:edit, :update, :destroy]

  def index
    @artists = Artist.all
    respond_with(@artists)
  end

  def edit
  end

  def update
    @artist.update_attributes(artist_params)
    respond_with @artist, :location => admin_artists_path
  end

  def destroy
    if @artist.destroy
      flash[:success] = "Sucessfully deleted."
    else 
      flash[:error] = "Error in deleting art piece."
    end
    respond_with [:admin, @artist]
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

  def find_artist
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name, :bio, :website, :birthdate, :deathdate, :student, :faculty)
  end
end
