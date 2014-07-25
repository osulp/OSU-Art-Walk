class AddPercentForArtToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :percent_for_art, :boolean
  end
end
