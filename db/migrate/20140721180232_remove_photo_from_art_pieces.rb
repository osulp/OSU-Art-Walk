class RemovePhotoFromArtPieces < ActiveRecord::Migration
  def change
    remove_column :art_pieces, :photo, :string
  end
end
