require 'spec_helper'

describe Series do
  it {should have_many(:art_pieces).through(:art_piece_series)}
  it {should have_many(:art_piece_series)}
end
