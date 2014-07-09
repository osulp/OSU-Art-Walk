class Admin::ArtPiecesController < AdminController
  respond_to :html, :json
  
  def index
    @art_pieces = ArtPiece.all
  end

  def edit
    @art_piece = ArtPiece.find(params[:id])
  end

  def update
    @art_piece = ArtPiece.find(params[:id])
    @art_piece.update_attributes(art_piece_params)
    respond_with @art_piece, :location => admin_art_pieces_path
  end

  def destroy
     if ArtPiece.find(params[:id]).destroy
      redirect_to admin_art_pieces_path, :flash => { :success => "Sucessfully deleted." }
    else 
      redirect_to admin_art_pieces_path, :flash => { :error => "Error in deleting art piece." }
    end
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

  def art_piece_params
    params.require(:art_piece).permit(:title, :medium, :creation_date, :size, :legal_info, :temporary, :temporary_until, :private, :contact_info, :description, :on_campus)
  end

end
