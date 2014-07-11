require 'spec_helper'

describe "buildings" do
  let(:user) {}
  let(:building) {create(:building)}

  before do
    capybara_login(user) if user
    visit root_path
  end 

  context "when on the index page" do
    let(:user) {create(:user, :admin)}
    before do
      visit admin_buildings_path
    end

    context "and no buildings are present" do
      it "should display No Buildings Currently In Database" do
        expect(page).to have_content("No Buildings Currently In Database")
      end
    end

    it "should have a link to add a new building" do
      expect(page).to have_link("Add New Building")
    end 

    context "the add new building link" do
      it "should take you to the new building page" do
        click_link "Add New Building"
        expect(page).to have_content("New Building Page")
      end
    end

    context "and buildings are present" do
      before do
        building
        visit admin_buildings_path
      end
      it "should have links to edit and delete specific buildings" do
        within "#building-#{building.id}" do
          expect(page).to have_link "Edit"
          expect(page).to have_link "Delete"
        end
      end
      context "should let you fill in edited info" do
        before do
          within "#building-#{building.id}" do
            click_link "Edit"
          end
          fill_in "Name", :with => "New Test Name"
        end

        it "should save it" do
          click_button "Update Building"
          expect(page).to have_content("New Test Name")
          expect(building.reload.name).to eq "New Test Name"
        end
      end
      it "should let you delete the building" do
        within "#building-#{building.id}" do
          click_link "Delete"
        end
        expect(page).to_not have_selector("#building-#{building.id}")
      end
    end
  end

  context "when on the new Building page" do
    let(:user) {create(:user, :admin)}
    before do
      visit new_admin_building_path
    end
    context "should allow input of data" do
      before do
        fill_in "Name", :with => "Test Name"
      end
      it "should save it" do
        click_button "Create Building"
        expect(page).to have_content("Test Name")
        expect(Building.first.name).to eq "Test Name"
      end
    end
  end

end