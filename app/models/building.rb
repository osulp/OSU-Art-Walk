class Building < ActiveRecord::Base
  has_many :art_pieces, :through => :art_piece_buildings
  has_many :art_piece_buildings

  def reIndex
    art_pieces.reindex
  end

  def coords
    [name, lat, long].join("-|-")
  end
end
