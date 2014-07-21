class AddArtPiecePhotosToArtPieces < ActiveRecord::Migration
  def change
    add_reference :art_pieces, :art_piece_photos, index: true
  end
end
