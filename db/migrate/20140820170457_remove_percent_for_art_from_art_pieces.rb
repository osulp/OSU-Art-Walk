class RemovePercentForArtFromArtPieces < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :percent_for_art
  end
end
