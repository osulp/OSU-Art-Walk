class RemoveStudentPieceFromArtPieces < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :student_piece, :boolean
  end
end
