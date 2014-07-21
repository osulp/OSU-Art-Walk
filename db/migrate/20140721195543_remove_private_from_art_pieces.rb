class RemovePrivateFromArtPieces < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :private
  end
end
