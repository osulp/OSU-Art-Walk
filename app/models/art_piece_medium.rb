class ArtPieceMedium < ActiveRecord::Base
  belongs_to :art_piece
  belongs_to :medium
end
