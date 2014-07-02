class ArtPieces < ActiveRecord::Base

  validates :title, :presence => true 
end
