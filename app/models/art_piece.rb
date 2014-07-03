class ArtPiece < ActiveRecord::Base
  validates :title, :presence => true 

  searchable do
    text :title, :stored => true
  end

end
