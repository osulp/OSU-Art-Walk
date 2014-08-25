require 'spec_helper'

csv = Rails.root.join("spec", "fixtures", "fixture_data.csv")
describe ArtWalk::Importer do
  let(:file) {csv}
  subject {ArtWalk::Importer.new(file)}

  describe "#import!" do
    before do
      subject.import!
    end
    it "should create an art piece" do
      expect(ArtPiece.all.count).to eq 2
    end
  end
end

describe ArtWalk::Importer::RowCreator do
  let(:file) {csv}
  let(:row) {ArtWalk::Importer.new(file).rows.first}
  subject {ArtWalk::Importer::RowCreator.new(row)}

  describe "#import!" do
    let(:result) {subject.import!}
    it "should return an art piece" do
      expect(result).to be_kind_of ArtPiece
    end
    it "should have a title" do
      expect(result.title).to eq "Test Title"
    end
    it "should have contact info" do
      expect(result.contact_info).to eq "Public"
    end
    it "should have an artist" do
      expect(result.artists.first.name).to eq "Bob the Builder"
    end
    it "should have a building" do
      expect(result.building.name).to eq "Batcheller Hall"
    end
    it "should have a medium" do
      expect(result.media.first.medium).to eq "mural"
    end
    it "should have a description" do
      expect(result.description).to eq "Test Description"
    end
    it "should have a year" do
      expect(result.creation_date).to eq "1999"
    end
    it "should have a size" do
      expect(result.size).to eq "19 1/4\" x 23 1/4\""
    end
    it "should have artist comments" do
      expect(result.artist_comments).to eq "These are notes from the artist probably"
    end
    it "should have displayed status" do
      expect(result.displayed).to eq false
    end
    it "should have private status" do
      expect(result.private?).to eq false
    end
    it "should have a collection" do
      expect(result.collections.first.name).to eq "New Collection"
    end
    it "should have a number" do
      expect(result.number).to eq "1"
    end
    it "should have an art piece building position number" do
      expect(result.art_piece_building.position_num).to eq 1
    end
    it "should have an art piece building location" do
      expect(result.art_piece_building.location).to eq "second floor, near room 241, through KOAC door"
    end
    it "should have a series" do
      expect(result.series.count).to eq 2
    end
    context "if the title that is read in is blank" do
      let(:row) {ArtWalk::Importer.new(file).rows.to_a.last}

      it "should have untitled as the title" do
        expect(result.title).to eq "untitled"
      end
    end
    context "if a series has 'part of' in the name" do
      it "should not have it when it is imported" do
        expect(result.series.first.name).to eq "Banana Series"
      end
    end
    context "if a collection 'has part' of in the name" do
      it "should not have it when it is imported" do
        expect(result.collections.last.name).to eq "New Collection"
      end
    end
  end
end
