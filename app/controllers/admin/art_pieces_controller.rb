class Admin::ArtPiecesController < AdminController
  respond_to :html, :json
  before_filter :find_art_piece, :only => [:edit, :update, :destroy]
  
  def index
    @art_pieces = PaginatingDecorator.new(ArtPiece.order(:title => :asc).includes(:art_piece_photos).page(params[:page]))
    @art = ArtPiece.all
    respond_to do |format|
      format.html
      format.json
      format.csv { send_data @art.to_csv }
    end
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
    params.require(:art_piece).permit(:title, :global_photo_credit, :creation_date, :size, :legal_info, :private, :contact_info, :description, :artist_comments, :displayed, :number, :lat, :long, :building, art_piece_photo_ids:[], art_piece_photos_attributes: [:photo, :photo_credit, :id, :_destroy], art_piece_building_attributes: [:building_id, :location, :art_piece_id, :position_num, :id], artist_ids: [], collection_ids:[], series_ids:[], medium_ids:[])
  end
end
