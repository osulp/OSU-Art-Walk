class ArtPiece < ActiveRecord::Base
  validates :title, :presence => true 

  has_one :building, :through => :art_piece_building
  has_one :art_piece_building

  searchable do
    text :title, :stored => true
  end

end
