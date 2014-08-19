class Series < ActiveRecord::Base
  has_many :art_pieces, :through => :art_piece_series
  has_many :art_piece_series
end
