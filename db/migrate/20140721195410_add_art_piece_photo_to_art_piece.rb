class AddArtPiecePhotoToArtPiece < ActiveRecord::Migration
  def change
    add_reference :art_pieces, :art_piece_photo, index: true
  end
end
