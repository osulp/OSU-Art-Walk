class CreateArtPieceSeries < ActiveRecord::Migration
  def change
    create_table :art_piece_series do |t|
      t.references :art_pieces, :index => true
      t.references :series, :index => true
    end
  end
end
