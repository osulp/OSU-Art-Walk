class AddStudentPieceToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :student_piece, :boolean
  end
end
