class RemoveMediumFromArtPieces < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :medium
  end
end
