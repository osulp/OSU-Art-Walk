require 'spec_helper'

describe 'Art Piece Lat Longs', :js => true do
  let(:art_piece1){create(:art_piece, :lat => 10, :long => 10)}
  let(:art_piece2){create(:art_piece, :with_building, :lat => 10, :long => 10)}

  context "when two art pieces exist" do

    before do
      art_piece1
      art_piece2
      visit root_path
    end

    context "One with building and one without" do
      it "should prefer art piece lat longs over building lat longs" do
        expect(page).to have_selector('.leaflet-marker-icon', :text => "2")
      end
    end
  end

  context "when only one art piece exists" do
    let(:art_piece1){create(:art_piece, :with_building)}

    context "with a building but no lat longs" do
      before do
        art_piece1
        visit root_path
      end

      it "should still display it on map" do
        expect(page).to have_selector('.leaflet-marker-icon')
      end
    end             
  end
end