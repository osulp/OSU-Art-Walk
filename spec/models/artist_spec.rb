require 'spec_helper'

describe Artist do

  describe "#art_piece" do
    it {should have_many(:art_pieces).through(:art_piece_artists)}
    it {should have_many(:art_piece_artists)}
  end
end
