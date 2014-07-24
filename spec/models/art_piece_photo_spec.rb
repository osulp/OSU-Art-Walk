require 'spec_helper'

describe ArtPiecePhoto do
  it {should belong_to(:art_piece)}
  it {should validate_presence_of(:photo)}
end
