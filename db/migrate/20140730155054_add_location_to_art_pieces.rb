class AddLocationToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :location, :text
  end
end
