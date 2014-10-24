require 'spec_helper'

describe "searching" do
  let(:item) {create(:art_piece)}
  context "when there is a an item" do
    let(:search_string) {""}
    before do
      item
      visit root_path
      fill_in "Search...", :with => search_string
      click_button "Search"
    end
    context "and a blank string is searched" do
      before do
        click_link "List"
      end
      it "should find it" do
        expect(page).to have_selector(".document")
        expect(page).to have_content(item.title)
      end
      context "and the 10 per page button is clicked", :js => true do
        before do
          click_button "10 per page"
        end
        it "should open the dropdown" do
          expect(page).to have_selector(".open")
        end
      end
    end
    context "and a part is searched for" do
      before do
        click_link "List"
      end
      let(:item) {create(:art_piece, :title => "Warmest")}
      let(:search_string) {"warm"}
      it "should find it" do
        expect(page).to have_selector('.document')
      end
    end
    context "and its title is searched" do
      before do
        click_link "List"
      end
      let(:search_string) {item.title}
      it "should find it" do
        expect(page).to have_selector(".document")
        expect(page).to have_content(item.title)
      end
    end
    context "and displayed is false" do
      let(:item) {create(:art_piece, :displayed => false)}
      it "should not display the art piece" do
        expect(page).not_to have_selector('.document')
      end
    end
  end
  context "when there is an item with a building, medium, artist, and series", :js => true do
    let (:art_piece) {create(:art_piece, :with_building, :with_artist, :with_collection, :with_series, :with_medium)}
    before do
      art_piece
      @art_info = [art_piece.building.name, art_piece.artists.first.name, art_piece.collections.first.name, art_piece.series.first.name, art_piece.media.first.medium, art_piece.title, art_piece.description]
      visit root_path
    end
    it "should allow for each searchable text to be searched" do
      @art_info.each do |art_piece_info|
        fill_in "Search...", :with => art_piece_info
        click_button "Search"
        click_link "List"
        expect(page).to have_content(art_piece_info)
        page.save_screenshot('spec/fixtures/screenshot.png')
      end
    end
  end
end
