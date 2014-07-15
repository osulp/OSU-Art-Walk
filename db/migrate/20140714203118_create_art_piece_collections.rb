class CreateArtPieceCollections < ActiveRecord::Migration
  def change
    create_table :art_piece_collections do |t|
      t.references :art_pieces, index: true
      t.references :collections, index: true

      t.timestamps
    end
  end
end
