class ArtPieceSeries < ActiveRecord::Base
  belongs_to :art_piece
  belongs_to :series
end
