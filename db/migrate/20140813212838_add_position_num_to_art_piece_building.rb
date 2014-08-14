class AddPositionNumToArtPieceBuilding < ActiveRecord::Migration
  def change
    add_column :art_piece_buildings, :position_num, :integer
  end
end
