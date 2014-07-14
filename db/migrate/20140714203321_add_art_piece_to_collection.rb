class AddArtPieceToCollection < ActiveRecord::Migration
  def change
    add_reference :collections, :art_pieces, index: true
  end
end
