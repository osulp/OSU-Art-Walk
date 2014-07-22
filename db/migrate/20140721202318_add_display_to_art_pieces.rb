class AddDisplayToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :displayed, :boolean, :default => true
  end
end

