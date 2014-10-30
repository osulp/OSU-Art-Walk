require 'spec_helper'

files = Rails.root.join("spec", "fixtures", "photos")
csv = Rails.root.join("spec", "fixtures", "fixture_data_5.csv")

describe ArtWalk::PhotoImporter do
  let(:photos) {files}
  let (:art_piece_importer) {ArtWalk::Importer.new(csv)}
  subject {ArtWalk::PhotoImporter.new(photos)}

  describe "#import!" do
    before do
      art_piece_importer
      art_piece_importer.import!
      subject.import!
    end
    it "should create 5 artists (3 single and 1 double artist pictrues)" do
      expect(Artist.all.count).to eq 5
    end
    it "should create 4 art pieces" do
      expect(ArtPiece.all.count).to eq 4
    end
    it "should have a photo attached to each art piece" do
      ArtPiece.all.each do |art|
        expect(art.art_piece_photos.count).to eq 1
      end
    end
  end
end
