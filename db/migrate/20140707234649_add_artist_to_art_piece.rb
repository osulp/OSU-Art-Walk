class AddArtistToArtPiece < ActiveRecord::Migration
  def change
    add_reference :art_pieces, :artist, index: true
  end
end
