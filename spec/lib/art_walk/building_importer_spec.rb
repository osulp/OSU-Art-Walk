require 'spec_helper'

csv = Rails.root.join("spec", "fixtures", "fixture_data_2.csv")
describe ArtWalk::BuildingImporter do
  let(:file) {csv}
  subject {ArtWalk::BuildingImporter.new(file)}

  describe "#import!" do
    before do
      subject.import!
    end
    it "should create an art piece" do
      expect(Building.all.count).to eq 1
    end
  end
  describe "#import!" do
    before do
      2.times do
        subject.import!
      end
    end
    it "should create an art piece" do
      expect(Building.all.count).to eq 1
    end
  end
end

describe ArtWalk::BuildingImporter::RowCreator do
  let(:file) {csv}
  let(:row) {ArtWalk::BuildingImporter.new(file).rows.first}
  subject {ArtWalk::BuildingImporter::RowCreator.new(row)}

  describe "#import!" do
    let(:result) {subject.import!}
   
    it "should return a building" do
      expect(result).to be_kind_of Building
    end
    it "should have a lat" do
      expect(result.lat).to eq 44.561402
    end
    it "should have a long" do
      expect(result.long).to eq -123.274645
    end
  end
end
