class AddSeriesToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :series, :string
  end
end
