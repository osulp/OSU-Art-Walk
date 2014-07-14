class ArtPieceCollection < ActiveRecord::Base
  belongs_to :art_piece
  belongs_to :collection
end
