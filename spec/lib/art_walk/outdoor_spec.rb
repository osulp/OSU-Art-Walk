require 'spec_helper'

csv = Rails.root.join("spec", "fixtures", "fixture_data_4.csv")
describe ArtWalk::OutdoorCoordsImporter do
  let(:file) {csv}
  subject {ArtWalk::OutdoorCoordsImporter.new(file)}

  describe "#import!" do
    before do
      2.times do
        subject.import!
      end
    end
    it "should create two art pieces" do
      expect(ArtPiece.all.count).to eq 2
    end
  end
end

describe ArtWalk::OutdoorCoordsImporter::RowCreator do
  let(:file) {csv}
  let(:row) {ArtWalk::OutdoorCoordsImporter.new(file).rows.first}
  subject {ArtWalk::OutdoorCoordsImporter::RowCreator.new(row)}

  describe "#import!" do
    let(:result) {subject.import!}

    it "should return two art pieces" do
      expect(result).to be_kind_of ArtPiece
    end
    it "should have a lat" do
      expect(result.lat.to_f).to eq 44.560297
    end
    it "should have a long" do
      expect(result.long.to_f).to eq -123.276629
    end
  end
end
