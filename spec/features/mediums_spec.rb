require 'spec_helper'

describe "medium manipulation" do
  let(:user) {}
  let(:medium) {create(:medium)}

  before do
    capybara_login(user) if user
    visit root_path
  end 

  context "when on the index page" do
    let(:user) {create(:user, :admin)}

    before do
      visit admin_media_path
    end

    context "and no mediums are present in the database" do

      it "should display No mediums Are Currently In The Database" do
        expect(page).to have_content("No Mediums Found In Database")
      end
    end

    context "and mediums are present in the database" do
      let(:medium) {create(:medium)}
      before do
        medium
        visit admin_media_path
      end
      it "should display the medium and all the information about them" do
        expect(page).to have_content(medium.medium)
      end

      it "should have an edit and delete links for the specific medium" do
        within "#medium-#{medium.id}" do
          expect(page).to have_link "Edit"
          expect(page).to have_link "Delete"
        end
      end

      context "when clicking the edit button for a specific medium" do
        before do
          within "#medium-#{medium.id}" do
            click_link "Edit"
          end
        end

        it "should take you to the editing page to edit that medium" do
          expect(page).to have_content("Edit")
        end
      end

      context "when clicking the add medium link" do

        it "should take you to the add new medium page" do
          click_link "Add Medium"
          expect(page).to have_content("New")
        end
      end
    end
  end

  context "when on the edit page" do
    let(:user) {create(:user, :admin)}

    context "and mediums are present" do
      before do
        medium
        visit admin_media_path
      end

      context "should let you edit the medium" do
        before do
          click_link "Edit"
          fill_in "Medium", :with => "This is the brand new name!"
          click_button "Update Medium"
        end

        it "should save it" do
          expect(page).to have_content("This is the brand new name!")
          expect(medium.reload.medium).to eq "This is the brand new name!"
        end
      end

      it "should let you delete a specific medium" do
        click_link "Delete"
        expect(page).to_not have_content(medium.medium)
      end
    end
  end

  context "when on the add medium page" do
    let(:user) {create(:user, :admin)}
    before do
      visit new_admin_medium_path
    end

    context "should let you fill in the forms" do
      before do
        fill_in "Medium", :with => "Here's a cool name"
        click_button "Create Medium"
      end
      it "should save it" do
        expect(page).to have_content("Here's a cool name")
        expect(Medium.first.medium).to eq "Here's a cool name"
      end
    end
  end

end