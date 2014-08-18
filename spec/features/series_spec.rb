require 'spec_helper'

describe "series manipulation" do
  let(:user) {}
  let(:series) {create(:series)}

  before do
    capybara_login(user) if user
    visit root_path
  end 

  context "when on the index page" do
    let(:user) {create(:user, :admin)}

    before do
      visit admin_series_index_path
    end

    context "and no series are present in the database" do

      it "should display No series Are Currently In The Database" do
        expect(page).to have_content("No Series Found In Database")
      end
    end

    context "and series are present in the database" do
      let(:series) {create(:series)}
      before do
        series
        visit admin_series_index_path
      end
      it "should display the series and all the information about them" do
        expect(page).to have_content(series.name)
      end

      it "should have an edit and delete links for the specific series" do
        within "#series-#{series.id}" do
          expect(page).to have_link "Edit"
          expect(page).to have_link "Delete"
        end
      end

      context "when clicking the edit button for a specific series" do
        before do
          within "#series-#{series.id}" do
            click_link "Edit"
          end
        end

        it "should take you to the editing page to edit that series" do
          expect(page).to have_content("Edit")
        end
      end

      context "when clicking the add series link" do

        it "should take you to the add new series page" do
          click_link "Add Series"
          expect(page).to have_content("New")
        end
      end
    end
  end

  context "when on the edit page" do
    let(:user) {create(:user, :admin)}

    context "and series are present" do
      before do
        series
        visit admin_series_index_path
      end

      context "should let you edit the series" do
        before do
          click_link "Edit"
          fill_in "Name", :with => "This is the brand new name!"
          click_button "Update Series"
        end

        it "should save it" do
          expect(page).to have_content("This is the brand new name!")
          expect(series.reload.name).to eq "This is the brand new name!"
        end
      end

      it "should let you delete a specific series" do
        click_link "Delete"
        expect(page).to have_content("Sucessfully deleted.")
      end
    end
  end

  context "when on the add series page" do
    let(:user) {create(:user, :admin)}
    before do
      visit new_admin_series_path
    end

    context "should let you fill in the forms" do
      before do
        fill_in "Name", :with => "Here's a cool name"
        click_button "Create Series"
      end
      it "should save it" do
        expect(page).to have_content("Here's a cool name")
        expect(Series.first.name).to eq "Here's a cool name"
      end
    end
  end

end
