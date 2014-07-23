class ArtPiecePhoto < ActiveRecord::Base
  belongs_to :art_piece
  validates :photo, :presence => true

  mount_uploader :photo, PhotoUploader
end
