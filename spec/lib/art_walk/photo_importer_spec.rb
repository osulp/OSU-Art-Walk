require 'spec_helper'

files = Rails.root.join("spec", "fixtures", "photos")

describe ArtWalk::PhotoImporter do
  let(:photos) {files}
  subject {ArtWalk::PhotoImporter.new(photos)}

  describe "#import!" do
    before do
      subject.import!
    end
    it "should create two artists" do
      expect(Artist.all.count).to eq 2
    end
    it "should create two art pieces" do
      expect(ArtPiece.all.count).to eq 2
    end
    it "should have a photo attached to each art piece" do
      expect(ArtPiece.first.art_piece_photos.count).to eq 1
      expect(ArtPiece.last.art_piece_photos.count).to eq 1
    end
  end
end
