require 'spec_helper'

describe 'Building association' do
  let(:user) {create(:user, :admin)}
  let(:building) {create(:building)}

  before do
    user
    building
    capybara_login(user) if user
    visit new_admin_art_piece_path
  end
  context "when adding/editing an art piece" do

    context "when selecting a building" do

      before do
        fill_in "Title", :with => "Sample Title"
        select building.name, :from => "Building"
        click_button "Create Art piece"
      end

      it "should save the building to the art_piece" do
        expect(page).to have_content(building.name)
      end
    end

  end
end