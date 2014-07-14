require 'spec_helper'

describe Collection do
  it {should have_many(:art_pieces).through(:art_piece_collections)}
  it {should have_many(:art_piece_collections)}
end
