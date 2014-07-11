class ArtPieceArtist < ActiveRecord::Base
  belongs_to :art_piece
  belongs_to :artist
end
