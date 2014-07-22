class AddArtPieceToArtPiecePhotos < ActiveRecord::Migration
  def change
    add_reference :art_piece_photos, :art_piece, index: true
  end
end
