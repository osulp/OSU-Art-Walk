require 'spec_helper'

describe 'Art Piece Lat Longs', :js => true do
  let(:art_piece1){create(:art_piece, :lat => 10, :long => 10)}
  let(:art_piece2){create(:art_piece, :with_building, :lat => 10, :long => 10)}

  before do
    art_piece1
    art_piece2
    visit root_path
  end

  context "when two art pieces exist one with building and one without" do 
    it "should display both on the map" do
      expect(page).to have_selector('.leaflet-marker-icon', :count => 2)
    end
  end
end