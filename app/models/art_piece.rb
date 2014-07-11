class ArtPiece < ActiveRecord::Base
  validates :title, :presence => true 

  has_one :building, :through => :art_piece_building
  has_one :art_piece_building

  has_many :artists, :through => :art_piece_artists
  has_many :art_piece_artists

  searchable do
    text :title, :stored => true
  end

end
