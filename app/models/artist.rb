class Artist < ActiveRecord::Base
  has_many :art_pieces, :through => :art_pieces_artists
  
end
