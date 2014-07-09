class ArtPiece < ActiveRecord::Base
  validates :title, :presence => true 

  has_one :building, :through => :art_piece_building
  has_one :art_piece_building

  has_many :artists, :through => :art_pieces_artists

  searchable do
    text :title, :stored => true
  end

end
