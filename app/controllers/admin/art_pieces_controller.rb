class Admin::ArtPiecesController < AdminController
  respond_to :html, :json
  before_filter :find_art_piece, :only => [:edit, :update, :destroy]
  
  def index
    @art_pieces = ArtPiece.all
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
  end

  def create
    @art_piece = ArtPiece.new(art_piece_params)
    flash[:success] = "Successfully created art piece!" if @art_piece.save
    respond_with @art_piece, :location => admin_art_pieces_path
  end

  private

  def find_art_piece
    @art_piece = ArtPiece.find(params[:id])
  end

  def art_piece_params
    params.require(:art_piece).permit(:title, :medium, :creation_date, :size, :legal_info, :private, :contact_info, :description, :displayed, :photo)
  end
end
