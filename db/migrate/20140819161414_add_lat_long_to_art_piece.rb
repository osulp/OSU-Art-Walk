class AddLatLongToArtPiece < ActiveRecord::Migration
  def change
    add_column :art_pieces, :lat, :decimal, :precision => 10, :scale => 6
    add_column :art_pieces, :long, :decimal, :precision => 10, :scale => 6
  end
end
