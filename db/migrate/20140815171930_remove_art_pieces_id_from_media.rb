class RemoveArtPiecesIdFromMedia < ActiveRecord::Migration
  def change
    remove_column :media, :art_pieces_id
  end
end
