class RemoveMediumIdFromArtPieces < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :medium_id
  end
end
