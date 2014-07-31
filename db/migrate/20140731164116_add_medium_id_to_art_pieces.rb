class AddMediumIdToArtPieces < ActiveRecord::Migration
  def change
    add_reference :art_pieces, :medium, index: true
  end
end
