require "spec_helper"

describe "map show", :js => true do
  let(:art_piece) {create(:art_piece, :with_building)}
  let(:art_piece1) {create(:art_piece, :title => "Art.")}
  context "when on the index page" do
    before do
      visit root_path
    end
    context "when visiting art piece from index map view" do
      context "and there is one art piece" do
        before do
          art_piece
          visit root_path
        end
        context "and the art piece show is visited" do
          before do
            find(".leaflet-marker-icon").click
            within("#blacklight-map-sidebar") do
              click_link art_piece.title
            end
          end
          it "should not have next and prev. arrows" do
            expect(page).to_not have_selector("#previousNextDocument")
          end
        end
      end
      context "and there is more than one art piece" do
        before do
          art_piece
          art_piece1.building = art_piece.building
          art_piece1.save
          visit root_path
        end
        context "and the first art piece show is visited" do
          before do
            find(".leaflet-marker-icon").click
            within("#blacklight-map-sidebar") do
              click_link ArtPiece.first.title
            end
          end
          it "should have next and prev. arrows" do
            within("#previousNextDocument") do
              expect(page).to have_link("Next »")
              expect(page).to have_content("« Previous")
            end
          end
        end
      end
    end
    context "when visiting art piece from a blank search and the map" do
      context "and there is one art piece" do
        before do
          art_piece
          visit root_path
          click_button "Search"
        end
        context "and the art piece show is visited" do
          before do
            find(".leaflet-marker-icon").click
            within("#blacklight-map-sidebar") do
              click_link art_piece.title
            end
          end
          it "should not have next and prev. arrows" do
            expect(page).to_not have_selector("#previousNextDocument")
          end
        end
      end
      context "and there is more than one art piece" do
        before do
          art_piece
          art_piece1.building = art_piece.building
          art_piece1.save
          visit root_path
          click_button "Search"
        end
        context "and the first art piece show is visited" do
          before do
            find(".leaflet-marker-icon").click
            within("#blacklight-map-sidebar") do
              click_link ArtPiece.first.title
            end
          end
          it "should have next and prev. arrows" do
            within("#previousNextDocument") do
              expect(page).to have_link("Next »")
              expect(page).to have_content("« Previous")
            end
          end
        end
      end
    end
    context "when visiting an art piece from the list view first, then the map view" do
      before do
        art_piece
        art_piece1.building = art_piece.building
        visit root_path
        click_button "Search"
        click_link "List"
        click_link art_piece.title
        click_button "Search"
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          click_link art_piece.title
        end
      end
      it "should have only one next, ect. bar" do
        expect(page).to have_selector("#previousNextDocument")
        within("#previousNextDocument") do
          expect(page).to have_link("Next »")
          expect(page).to have_content("« Previous")
        end
      end
    end
  end
end
