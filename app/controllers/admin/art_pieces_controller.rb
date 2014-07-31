class Admin::ArtPiecesController < AdminController
  respond_to :html, :json
  before_filter :find_art_piece, :only => [:edit, :update, :destroy]
  
  def index
    @art_pieces = ArtPiece.all.includes(:art_piece_photos).decorate
    respond_with(@art_pieces)
  end

  def edit
  end

  def update
    @art_piece.update_attributes(art_piece_params)
    respond_with @art_piece, :location => admin_art_pieces_path
  end

  def destroy
    if @art_piece.destroy
      flash[:success] = "Sucessfully deleted."
    else 
      flash[:error] = "Error in deleting art piece."
    end
    respond_with [:admin, @art_piece]
  end

  def new
    @art_piece = ArtPiece.new
    @art_piece.art_piece_photos.build
    @art_piece.build_art_piece_building
  end

  def create
    @art_piece = ArtPiece.new(art_piece_params)
    flash[:success] = "Successfully created art piece!" if @art_piece.save
    respond_with @art_piece, :location => admin_art_pieces_path
  end

  private

  def find_art_piece
    @art_piece = ArtPiece.includes(:art_piece_photos).find(params[:id])
  end

  def art_piece_params
    params.require(:art_piece).permit(:title, :creation_date, :size, :legal_info, :private, :contact_info, :description, :displayed, :number, :series, :percent_for_art, :building, :medium_id, art_piece_photo_ids:[], art_piece_photos_attributes: [:photo, :id, :_destroy], art_piece_building_attributes: [:building_id, :location, :art_piece_id, :id], artist_ids: [], collection_ids:[])
  end
end
