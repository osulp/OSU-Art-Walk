class RenameArtPiecesArtists < ActiveRecord::Migration
  def change
    rename_table :art_pieces_artists, :art_piece_artists
  end
end
