require 'spec_helper'

describe Building do

  describe "#ArtPiece" do
    subject {create(:building)}
    let(:art_piece) {create(:art_piece)}
    let(:art_piece_2) {create(:art_piece)}

    context "When an art piece is set" do
      before do
        subject.art_pieces = [art_piece]
        subject.save
      end

      it "should work" do
        expect(subject.art_pieces).to eq [art_piece]
      end
    end

    context "When multiple art pieces are set" do
      before do
        subject.art_pieces = [art_piece, art_piece_2]
        subject.save
      end

      it "should work" do
        expect(subject.art_pieces).to eq [art_piece, art_piece_2]
      end

      context "if art pieces are removed" do
        before do
          subject.art_pieces = []
          subject.save
        end
        it "should reset buildings for the art pieces" do
          expect(art_piece.building).to eq nil
        end
      end
    end
  end

  describe "#coords" do
    let(:building) {create(:building) }

    before do
      building
    end
    it "should return a placename_coords string" do
      expect(building.coords).to eq "#{building.name}-|-#{building.lat}-|-#{building.long}"
    end
  end
end

