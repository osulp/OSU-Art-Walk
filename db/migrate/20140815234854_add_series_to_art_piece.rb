class AddSeriesToArtPiece < ActiveRecord::Migration
  def change
    add_reference :art_pieces, :series, :index => true
  end
end
