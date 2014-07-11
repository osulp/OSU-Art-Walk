require 'spec_helper'

describe ArtPiece do
  subject {build(:art_piece)}

  describe "Validations" do

    context "Presence check" do
      it {should validate_presence_of(:title)}
    end
  end

  describe "#building" do
    subject {create(:art_piece)}
    let(:building) {create(:building)}
    let(:building_2) {create(:building)}
    context "when a building is set" do
      before do
        subject.building = building
        subject.save
      end
      it "should work" do
        expect(subject.building).to eq building
      end
      it "should not be able to append another building" do
        expect{subject.building << building_2}.to raise_error
      end
      it "should set art pieces for the building" do
        expect(building.art_pieces).to eq [subject]
      end
      context "if buildings are removed" do
        before do
          subject.building = nil
          subject.save
        end
        it "should reset art pieces for the building" do
          expect(building.art_pieces).to eq []
        end
      end
    end
  end
  it {should have_many(:artists).through(:art_piece_artists)}
  it {should have_many(:art_piece_artists)}
end
