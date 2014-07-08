class ArtPieceBuilding < ActiveRecord::Base
  belongs_to :art_piece
  belongs_to :building
end
