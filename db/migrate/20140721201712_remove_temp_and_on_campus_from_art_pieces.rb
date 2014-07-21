class RemoveTempAndOnCampusFromArtPieces < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :temporary
    remove_column :art_pieces, :temporary_until
    remove_column :art_pieces, :on_campus
  end
end
