class CreateArtPiecesArtists < ActiveRecord::Migration
  def change
    create_table :art_pieces_artists do |t|
      t.references :art_piece, index: true
      t.references :artist, index: true

      t.timestamps
    end
  end
end
