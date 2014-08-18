class ChangeArtPieceReferenceInArtPieceSeries < ActiveRecord::Migration
  def change
    change_table :art_piece_series do |t|
      t.rename :art_pieces_id, :art_piece_id
    end
  end
end
