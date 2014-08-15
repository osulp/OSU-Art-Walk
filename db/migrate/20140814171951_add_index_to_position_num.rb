class AddIndexToPositionNum < ActiveRecord::Migration
  def change
    add_index :art_piece_buildings, :position_num
  end
end
