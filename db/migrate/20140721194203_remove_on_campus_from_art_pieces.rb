class RemoveOnCampusFromArtPieces < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :on_campus
    remove_column :art_pieces, :temporary
    remove_column :art_pieces, :temporary_until
    add_column :art_pieces, :display, :boolean, :default => true
  end
end
