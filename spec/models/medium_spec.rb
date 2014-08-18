require 'spec_helper'

describe Medium do
  #Relations
  it {should have_many(:art_pieces).through(:art_piece_media)}
  it {should have_many(:art_piece_media)}
end
