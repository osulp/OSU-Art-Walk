require 'spec_helper'

describe 'blacklight maps' do
  context "when an art piece exists with a building", :js => true do
    let(:art_piece) {create(:art_piece, :with_building, :with_artist)}
    before do
      art_piece
    end
    context "and the root page is visited" do
      before do
        visit root_path
      end
      it "should show a marker" do
        expect(page).to have_selector(".leaflet-marker-icon")
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
      end
    end
  end
end
