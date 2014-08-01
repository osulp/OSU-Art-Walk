class Artist < ActiveRecord::Base
  has_many :art_pieces, :through => :art_piece_artists
  has_many :art_piece_artists
  after_save :reindex_art_pieces

  private

  def reindex_art_pieces
    art_pieces.each(&:index)
  end

end
