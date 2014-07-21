class ArtPiecePhoto < ActiveRecord::Base
  belongs_to :art_piece

  mount_uploader :photo, PhotoUploader
end
