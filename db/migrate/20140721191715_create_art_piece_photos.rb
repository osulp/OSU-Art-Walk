class CreateArtPiecePhotos < ActiveRecord::Migration
  def change
    create_table :art_piece_photos do |t|
      t.string :photo

      t.timestamps
    end
  end
end
