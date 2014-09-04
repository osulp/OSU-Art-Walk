require 'spec_helper'

csv = Rails.root.join("spec", "fixtures", "fixture_data_3.csv")
describe ArtWalk::ArtistImporter do
  let(:file) {csv}
  subject {ArtWalk::ArtistImporter.new(file)}

  describe "#import!" do
    before do
      subject.import!
    end
    it "should create an art piece" do
      expect(Artist.all.count).to eq 1
    end
  end
  describe "#import! ran two times" do
    before do
      2.times do
        subject.import!
      end
    end
    it "should create an art piece" do
      expect(Artist.all.count).to eq 1
    end
  end
end

describe ArtWalk::ArtistImporter::RowCreator do
  let(:file) {csv}
  let(:row) {ArtWalk::ArtistImporter.new(file).rows.first}
  subject {ArtWalk::ArtistImporter::RowCreator.new(row)}

  describe "#import!" do
    let(:result) {subject.import!}
   
    it "should return an artist" do
      expect(result).to be_kind_of Artist
    end
    it "should have a bio" do
      expect(result.bio).to eq "Test Bio"
    end
    it "should have a website" do
      expect(result.website).to eq "http://www.markabrahamson.com/index/html"
    end
    it "should have a birthdate" do
      expect(result.birthdate).to eq "1944"
    end
    it "should have a deathdate" do
      expect(result.deathdate).to eq "2070"
    end
    it "should have a student status" do
      expect(result.student).to eq true
    end
    it "should have a faculty status" do
      expect(result.faculty).to eq true
    end
  end
end
