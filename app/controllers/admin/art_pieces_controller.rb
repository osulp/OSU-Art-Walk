class Admin::ArtPiecesController < AdminController
  respond_to :html, :xml, :json
  
  def index
    @artPieces = ArtPiece.all
  end

  def edit
    @artPiece = ArtPiece.find(params[:id])
  end

  def update
    @artPiece = ArtPiece.find(params[:id])
    @artPiece.update_attributes(art_piece_params)
    respond_with @artPiece, :location => admin_art_pieces_path
  end

  def destroy
    ArtPiece.find(params[:id]).destroy
    redirect_to admin_art_pieces_path, :flash => { :success => "Sucessfully deleted." }
  end

  def new
    @artPiece = ArtPiece.new
  end

  private

  def art_piece_params
    params.require(:art_piece).permit(:title, :medium, :creation_date, :size, :legal_info, :is_temporary, :temporary_until, :private, :contact_info, :description, :on_campus)
  end

end
