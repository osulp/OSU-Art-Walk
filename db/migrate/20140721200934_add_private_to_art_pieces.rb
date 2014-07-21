class AddPrivateToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :private, :boolean, :default => true
  end
end
