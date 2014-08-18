class AddArtPieceToSeries < ActiveRecord::Migration
  def change
    add_reference :series, :artpieces, :index => true
  end
end
