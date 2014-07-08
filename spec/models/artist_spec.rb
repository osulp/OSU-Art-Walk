require 'spec_helper'

describe Artist do
  subject {build(:artist)}

  it{should have_many(:art_pieces)}

  describe "#ArtPiece" do
    subject {create(:artist)}
    let(:artpiece) {create(:art_piece)}

    context "When an art piece is set" do

      before do
        subject.art_pieces = [artpiece]
        subject.save
      end

      it "should work" do
        expect(subject.art_pieces).to eq [artpiece]
      end

      context "when an art piece is removed" do

        before do
          artpiece.artist = nil
          subject.save
        end

        it "should not be there" do
          expect(artpiece.artist).to eq nil
        end
      end
    end
  end
end
