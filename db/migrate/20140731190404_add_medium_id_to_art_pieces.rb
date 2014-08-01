class AddMediumIdToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :medium_id, :integer
  end
end
