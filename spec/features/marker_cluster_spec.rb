require 'spec_helper'

describe "map markers", :js => true do
  let(:owen) {create(:building, :lat => 44.567030, :long => -123.273570)}
  let(:kearney) {create(:building, :lat => 44.567037, :long => -123.273184)}
  let(:art_piece) {create(:art_piece, :building => owen)}
  let(:art_piece2) {create(:art_piece, :building => kearney)}
  let(:art_piece3) {create(:art_piece, :building => kearney)}
  context "when there are two art pieces in buildings very close to each other" do
    before do
      art_piece
      art_piece2
      art_piece3
      visit root_path
    end
    it "should not group the art pieces" do
      expect(page).to have_selector(".leaflet-marker-icon", :text => "1")
      expect(page).to have_selector(".leaflet-marker-icon", :text => "2")
    end
  end
end
