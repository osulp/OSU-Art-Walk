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
        expect(building.reload.art_pieces).to eq [subject]
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

  #relations
  it {should have_many(:artists).through(:art_piece_artists)}
  it {should have_many(:art_piece_artists)}

  it {should have_many(:collections).through(:art_piece_collections)}
  it {should have_many(:art_piece_collections)}

  it {should have_many(:art_piece_photos)}
  it {should accept_nested_attributes_for(:art_piece_photos)}

  it {should have_many(:media).through(:art_piece_media)}
  it {should have_many(:art_piece_media)}

  #function tests

  describe "#status" do
    subject {create(:art_piece)}

    before do
      subject.artists = [artist]
    end
    context "As a student" do    
      let(:artist) {create(:artist, :student => true)}
      it "Should return Translated String for art_piece.student_string" do
        expect(subject.status).to eq [I18n.t('art_piece.student_string')]
      end
    end
    context "As a faculty" do    
      let(:artist) {create(:artist, :faculty => true)}
      it "Should return Translated String for art_piece.faculty_string" do
        expect(subject.status).to eq [I18n.t('art_piece.faculty_string')]
      end
    end 
  end
  describe "#display_status" do
    let(:art_piece_1) {create(:art_piece, :displayed => true)}
    let(:art_piece_2) {create(:art_piece, :displayed => false)}

    context "When displayed" do    
      before do
        art_piece_1
      end
      it "Should return translated string for art_piece.on_display_string" do
        expect(art_piece_1.display_status).to eq I18n.t('art_piece.on_display_string')
      end
    end
    context "when not displayed" do
      before do
        art_piece_2
      end   
      it "Should return Translated String for art_piece.not_on_display_string" do
        expect(art_piece_2.display_status).to eq I18n.t('art_piece.not_on_display_string')
      end
    end 
  end

end
