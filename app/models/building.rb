class Building < ActiveRecord::Base
  has_many :art_pieces, :through => :art_piece_buildings
  has_many :art_piece_buildings
  after_save :reindex_art_pieces

  def coords
    return nil if lat.blank? || long.blank?
    [name, lat, long].join("-|-")
  end

  private

  def reindex_art_pieces
    art_pieces.each(&:index)
  end

end
