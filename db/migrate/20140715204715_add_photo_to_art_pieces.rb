class AddPhotoToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :photo, :string
  end
end
