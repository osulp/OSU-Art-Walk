class Medium < ActiveRecord::Base
  has_many :art_pieces, :through => :art_piece_media
  has_many :art_piece_media
end
