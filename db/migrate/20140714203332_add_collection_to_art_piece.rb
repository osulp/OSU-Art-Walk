class AddCollectionToArtPiece < ActiveRecord::Migration
  def change
    add_reference :art_pieces, :collections, index: true
  end
end
