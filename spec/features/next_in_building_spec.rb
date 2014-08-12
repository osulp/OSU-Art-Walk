require "spec_helper"

describe "map index", :js => true do
  let(:art_piece) {create(:art_piece, :with_building)} #creates art pieces with random buildings
  let(:art_piece2) {create(:art_piece)} #creates art pieces to attach to all the same building
  let(:building) {create(:building)}
  context "when on the index view" do
    context "when there is one art piece" do
      before do
        art_piece
        visit root_path
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          click_link art_piece.title
        end
      end
      it "should not have any next/prev arrows" do
        expect(page).to_not have_selector("#previousNextDocument")
      end
    end
    context "when there are two art pieces in different buildings" do
      before do
        art_piece
        art_piece
        visit root_path
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          click_link art_piece.title
        end
      end
      it "should not have next/prev arrows" do
        expect(page).to_not have_selector("#previousNextDocument")
      end
    end
    context "when there are three art pieces in the same building" do
      let(:art1) {create(:art_piece)}
      let(:art2) {create(:art_piece)}
      let(:art3) {create(:art_piece)}
      before do
        building1 = building
        art3.building = building1
        art3.save
        art2.building = building1
        art2.save
        art1.building = building1
        art1.save
        visit root_path
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          click_link art1.title
        end
      end
      it "should have next/prev arrows and count of 3" do
        within("#previousNextDocument") do
          expect(page).to have_link("« Previous")
          expect(page).to have_content("Next »")
          expect(page).to have_content("3 of 3")
        end
      end
      context "and one of them is moved to another building" do
        let(:building2) {create(:building)}
        before do
          art3.building = building2
          art3.save
          visit root_path
          page.find(".leaflet-marker-icon", text: "2").click
          within("#blacklight-map-sidebar") do
            click_link art1.title
          end
        end
        it "should have next/prev arrows and count of 2" do
          within("#previousNextDocument") do
            expect(page).to have_content("Next »")
            expect(page).to have_link("« Previous")
            expect(page).to have_content("2 of 2")
          end
        end
      end
    end
  end
end
