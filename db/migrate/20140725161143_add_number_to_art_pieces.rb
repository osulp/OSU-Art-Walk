class AddNumberToArtPieces < ActiveRecord::Migration
  def change
    add_column :art_pieces, :number, :string
  end
end
