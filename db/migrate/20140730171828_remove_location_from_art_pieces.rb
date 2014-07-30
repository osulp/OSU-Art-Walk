class RemoveLocationFromArtPieces < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :location
  end
end
