class RemoveFacultyPieceFromArtPieces < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :faculty_piece, :boolean
  end
end
