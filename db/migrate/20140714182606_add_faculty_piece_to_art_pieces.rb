class AddFacultyPieceToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :faculty_piece, :boolean
  end
end
