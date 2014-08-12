require "spec_helper"

describe "map show", :js => true do
  let(:art_piece) {create(:art_piece, :with_building)}
  let(:art_piece1) {create(:art_piece, :title => "Art.")}
  context "when there is only one art piece" do
    before do
      art_piece
      visit root_path
    end
    context "and when visiting the art piece from index map view" do
      before do
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          click_link art_piece.title
        end
      end
      it "should not have the prev/next div" do
        expect(page).to_not have_selector("#previousNextDocument")
      end
    end
    context "and when visiting the art piece from blank search map view" do
      before do
        click_button "Search"
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          click_link art_piece.title
        end
      end
      it "should not have the prev/next div" do
        expect(page).to_not have_selector("#previousNextDocument")
      end
    end
    context "and when visiting the art piece the blank search map view after visiting from list view" do
      before do
        click_button "Search"
        click_link "List"
        click_link art_piece.title
        click_button "Search"
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          click_link art_piece.title
        end
      end
      it "should not have the prev/next div" do
        expect(page).to_not have_selector("#previousNextDocument")
      end
    end
  end
  context "when there is more than one art piece" do
    before do
      art_piece1.building = art_piece.building
      art_piece1.save
      visit root_path
    end
    context "and when visiting the art piece from index map view" do
      before do
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          click_link art_piece.title
        end
      end
      it "should have next and prev links" do
        within("#previousNextDocument") do
          expect(page).to have_content("« Previous")
          expect(page).to have_content("Next »")
        end
      end
    end
    context "and when visiting the art piece from blank search map view" do
      before do
        click_button "Search"
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          click_link art_piece.title
        end
      end
      it "should have next and prev links" do
        within("#previousNextDocument") do
          expect(page).to have_content("« Previous")
          expect(page).to have_link("Next »")
        end
      end
    end
    context "and when visiting the art piece the blank search map view after visiting from list view" do
      before do
        click_button "Search"
        click_link "List"
        click_link art_piece.title
        click_button "Search"
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          click_link art_piece.title
        end
      end
      it "should have next and prev links" do
        within("#previousNextDocument") do
          expect(page).to have_content("« Previous")
          expect(page).to have_link("Next »")
        end
      end
    end
  end
end
