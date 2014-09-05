class AddPhotoCreditToArtPiece < ActiveRecord::Migration
  def change
    add_column :art_pieces, :global_photo_credit, :string
  end
end
