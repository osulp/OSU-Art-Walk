class RemoveSeriesFromArtPiece < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :series
  end
end
