require 'spec_helper'

describe "search field dropdown" do
  let(:art_piece) {create(:art_piece, :with_artist, :with_building, :with_media, :with_collection)}
  before do
    art_piece
    visit root_path
  end
  context "when on the index page" do
    it "should have the dropdown with all the options" do
      expect(page).to have_selector("option", :count => 6)
      within(".search_field") do
        expect(page).to have_content("All Fields")
        expect(page).to have_content("Artists")
        expect(page).to have_content("Buildings")
        expect(page).to have_content("Title")
        expect(page).to have_content("Medium")
        expect(page).to have_content("Collection")
      end
    end
  end
  context "when searching for something in the database" do
    context "when searching by artist" do
      before do
        within("#search_field") do
          find("option", :text => "Artists").click
        end
        fill_in "Search...", :with => art_piece.artists.first.name
        click_button "Search"
        click_link "List"
      end
      it "should find the art piece" do
        expect(page).to have_content(art_piece.title)
      end
    end
    context "when searching by building" do
      before do
        within("#search_field") do
          find("option", :text => "Buildings").click
        end
        fill_in "Search...", :with => art_piece.building.name
        click_button "Search"
        click_link "List"
      end
      it "should find the art piece" do
        expect(page).to have_content(art_piece.title)
      end
    end
    context "when searching by title" do
      before do
        within("#search_field") do
          find("option", :text => "Titles").click
        end
        fill_in "Search...", :with => art_piece.title
        click_button "Search"
        click_link "List"
      end
      it "should find the art piece" do
        expect(page).to have_content(art_piece.artists.first.name)
      end
    end
    context "when searching by medium" do
      before do
        within("#search_field") do
          find("option", :text => "Medium").click
        end
        fill_in "Search...", :with => art_piece.art_piece_media.first.medium.medium
        click_button "Search"
        click_link "List"
      end
      it "should find the art piece" do
        expect(page).to have_content(art_piece.title)
      end
    end
    context "when searching by collection" do
      before do
        within("#search_field") do
          find("option", :text => "Collections").click
        end
        fill_in "Search...", :with => art_piece.collections.first.name
        click_button "Search"
        click_link "List"
      end
      it "should find the art piece" do
        expect(page).to have_content(art_piece.title)
      end
    end
  end
end
