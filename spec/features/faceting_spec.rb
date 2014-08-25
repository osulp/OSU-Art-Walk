require 'spec_helper'

describe "faceting" do

  before do
    subject
    visit root_path
  end

  context "when there is an art piece" do
    subject {create(:art_piece)}
    context "with a building" do
      subject {create(:art_piece, :with_building)}
      it "should have a link for that building" do
        expect(page).to have_link subject.building.name
      end
    end
    context "with an artist" do
      subject {create(:art_piece, :with_artist)}
      it "should have a link for that artist" do
        expect(page).to have_link subject.artists.name
      end
    end
    context "with a featured artist" do
      let(:featured_artist) {create(:artist, :featured => true)}
      let(:art_piece) {create(:art_piece, :with_building, :artists => [featured_artist])}
      let(:art_piece2) {create(:art_piece, :with_building, :with_artist)}

      before do
        art_piece
        art_piece2
        visit root_path
      end

      it "should have a featured artist facet" do
        expect(page).to have_link("Featured Artists")
      end
      it "should have the featured artists facet open by default" do
        expect(page).to have_selector(".in")
      end
      it "should not be displayed" do
        artist_links = all("#facet-featured_artists_sms ul li")
        expect(artist_links.length).to eq 1
      end
    end
    context "with a collection" do
      subject {create(:art_piece, :with_collection)}
      it "should have a link for that artist" do
        expect(page).to have_link subject.collections.name
      end
    end
    context "with a medium" do
      subject {create(:art_piece, :with_media)}
      it "should have a link for that medium" do
        expect(page).to have_link subject.media.first.medium
      end
    end
    context "with a status" do
      context "of student" do
        subject {create(:art_piece, :with_student)}
        it "should have a link for that status" do
          expect(page).to have_link("Created by Student")
        end
      end
      context "of faculty" do
        subject {create(:art_piece, :with_faculty)}
        it "should have a link for that status" do
          expect(page).to have_link("Created by Faculty")
        end
      end
    end
  end
end
