require 'spec_helper'

describe 'blacklight maps' do
  context "when there are 11 art pieces with buildings" do
    let(:building) {create(:building)}
    let(:user) {create(:user, :admin)}
    before do
      11.times do
        create(:art_piece, :building => building)
      end
    end
    context "when visiting the view by clicking the thumbnail", :js => true do
      before do
        capybara_login(user) if user
        visit new_admin_art_piece_path
        fill_in "Title", :with => "test title with photo"
        within("#picture") do
          attach_file("art_piece_art_piece_photos_attributes_0_photo", "spec/fixtures/cats.jpg")
        end
        click_button "Create Art piece"
        ArtPiece.last.building = building
        ArtPiece.last.save
        visit root_path
        find(".leaflet-marker-icon").click
        within("#blacklight-map-sidebar") do
          find("img").click
        end
      end
      it "should take you to the show with next and prev arrows" do
        expect(page).to have_content(ArtPiece.last.title)
        expect(page).to have_content("« Previous")
        expect(page).to have_link("Next »")
      end
    end
    context "when on the first page", :js => true do
      before do
        visit root_path
        click_button "Search"
      end
      it "should display all the art pieces" do
        expect(page).to have_selector(".leaflet-marker-icon", :text => "11")
      end
    end
    context "when on the second page", :js => true do
      before do
        visit root_path
        click_button "Search"
        within(".page_links") do
          click_link "Next »"
        end
      end
      it "should display all the art pieces" do
        expect(page).to have_selector(".leaflet-marker-icon", :text => "11")
      end
    end
  end
  context "when an art piece exists with a building", :js => true do
    let(:art_piece) {create(:art_piece, :with_building, :with_artist)}
    before do
      art_piece
    end
    context "and the root page is visited" do
      let(:setup) {}
      before do
        setup
        visit root_path
      end
      it "should show a marker" do
        expect(page).to have_selector(".leaflet-marker-icon")
      end
      context "and there are two art pieces" do
        let(:art_piece_2) {create(:art_piece, :with_building)}
        context "and the limit is one art piece per page" do
          let(:setup) do
            Blacklight::Configuration.any_instance.stub(:max_per_page).and_return(1)
            art_piece_2
          end
          context "and both are marked as displayed" do
            it "should show two markers" do
              expect(page).to have_selector(".leaflet-marker-icon", :count => 2)
            end
          end
          context "and one is marked as non-displayed" do
            let(:art_piece_2) {create(:art_piece, :with_building, :displayed => false)}
            before do
              art_piece
              art_piece_2
            end
            it "should only show one" do
              expect(page).to have_selector(".leaflet-marker-icon", :count => 1)
            end
          end
        end
      end
      context "and the marker is clicked" do
        before do
          find(".leaflet-marker-icon").click
        end
        it "should have a link to the art piece" do
          within(".leaflet-sidebar") do
            expect(page).to have_link(art_piece.title)
          end
        end
        it "should display the artist name" do
          within("#blacklight-map-sidebar") do
            art_piece.artists.each do |artist|
              expect(page).to have_content(artist.name)
            end
          end
        end
        it "should display a link to the building" do
          within("#blacklight-map-sidebar") do
            expect(page).to have_link(art_piece.building.name)
          end
        end
        context "when clicking on the building name" do
          before do
            find("h2").click
          end
          it "should go to the list view search results for that building" do
            within(".filterValue") do
              expect(page).to have_content(art_piece.building.name)
            end
            expect(page).to have_content(art_piece.title)
          end
        end
        context "when there is a location entered" do
          before do
            art_piece.art_piece_building.location = "this is where the art piece is"
            art_piece.save
            visit root_path
            find(".leaflet-marker-icon").click
          end
          it "should display the location of the art piece in the building" do
            within("#blacklight-map-sidebar") do
              expect(page).to have_content(art_piece.art_piece_building.location)
            end
          end
        end
        context "when there is not a location entered" do
          it "should not display the art piece location" do
            within(".leaflet-sidebar") do
              expect(page).to_not have_content("Location: ")
            end
          end
        end
      end
    end
  end
end
