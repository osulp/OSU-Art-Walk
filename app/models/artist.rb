class Artist < ActiveRecord::Base
  has_many :art_pieces, :through => :art_piece_artists
  has_many :art_piece_artists
  
end
