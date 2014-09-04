require 'spec_helper'

files = Rails.root.join("spec", "fixtures", "photos")

describe ArtWalk::PhotoImporter do
  let(:photos) {files}
  subject {ArtWalk::PhotoImporter.new(photos)}

  describe "#import!" do
    before do
      subject.import!
    end
    it "should create an artist" do
      expect(Artist.all.count).to eq 1
    end
    it "should create an art piece" do
      expect(ArtPiece.all.count).to eq 1
    end
    it "should have a photo attached to the art piece" do
      expect(ArtPiece.first.art_piece_photos.count).to eq 1
    end
  end
end
