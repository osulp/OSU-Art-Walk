require 'spec_helper'

describe 'building map' do
  let(:user) {create(:user, :admin)}

  before do
    capybara_login(user) if user
  end
  
  context "when on the new building page", :js => true do
    before do
      visit new_admin_building_path
    end

    it "should have the marker on the page" do
      expect(page).to have_selector('.leaflet-marker-icon')
    end
  end
  context "when on the edit building page", :js => true do
    before do
      visit new_admin_building_path
    end

    it "should have the marker on the page" do
      expect(page).to have_selector('.leaflet-marker-icon')
    end
  end
end