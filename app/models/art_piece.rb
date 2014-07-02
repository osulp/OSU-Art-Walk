class ArtPiece < ActiveRecord::Base
  validates :title, :presence => true 
end
