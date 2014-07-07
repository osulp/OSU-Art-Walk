class CreateArtPieceBuilding < ActiveRecord::Migration
  def change
    create_table :art_piece_buildings do |t|
      t.integer :floor
      t.string :location
      t.references :art_piece, index: true
      t.references :building, index: true
    end
  end
end
