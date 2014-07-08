class AddArtPieceToArtist < ActiveRecord::Migration
  def change
    add_reference :artists, :art_piece, index: true
  end
end
