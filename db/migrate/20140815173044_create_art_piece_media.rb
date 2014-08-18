class CreateArtPieceMedia < ActiveRecord::Migration
  def change
    create_table :art_piece_media do |t|
      t.references :art_piece, index: true
      t.references :medium, index: true

      t.timestamps
    end
  end
end
