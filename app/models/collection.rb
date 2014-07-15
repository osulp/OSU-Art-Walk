class Collection < ActiveRecord::Base
  has_many :art_pieces, :through => :art_piece_collections
  has_many :art_piece_collections
end
