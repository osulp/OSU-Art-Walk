require 'spec_helper'

describe "collection manipulation" do
  let(:user) {}
  let(:collection) {create(:collection)}

  before do
    capybara_login(user) if user
    visit root_path
  end 

  context "when on the index page" do
    let(:user) {create(:user, :admin)}

    before do
      visit admin_collections_path
    end

    context "and no collections are present in the database" do

      it "should display No collections Are Currently In The Database" do
        expect(page).to have_content("No Collections Found In Database")
      end
    end

    context "and collections are present in the database" do
      let(:collection) {create(:collection)}
      before do
        collection
        visit admin_collections_path
      end
      it "should display the collection and all the information about them" do
        expect(page).to have_content(collection.name)
      end

      it "should have an edit and delete links for the specific collection" do
        within "#collection-#{collection.id}" do
          expect(page).to have_link "Edit"
          expect(page).to have_link "Delete"
        end
      end

      context "when clicking the edit button for a specific collection" do
        before do
          within "#collection-#{collection.id}" do
            click_link "Edit"
          end
        end

        it "should take you to the editing page to edit that collection" do
          expect(page).to have_content("Edit")
        end
      end

      context "when clicking the add collection link" do

        it "should take you to the add new collection page" do
          click_link "Add Collection"
          expect(page).to have_content("New")
        end
      end
    end
  end

  context "when on the edit page" do
    let(:user) {create(:user, :admin)}

    context "and collections are present" do
      before do
        collection
        visit admin_collections_path
      end

      context "should let you edit the collection" do
        before do
          click_link "Edit"
          fill_in "Name", :with => "This is the brand new name!"
          click_button "Update Collection"
        end

        it "should save it" do
          expect(page).to have_content("This is the brand new name!")
          expect(collection.reload.name).to eq "This is the brand new name!"
        end
      end

      it "should let you delete a specific collection" do
        click_link "Delete"
        expect(page).to_not have_content(collection.name)
      end
    end
  end

  context "when on the add collection page" do
    let(:user) {create(:user, :admin)}
    before do
      visit new_admin_collection_path
    end

    context "should let you fill in the forms" do
      before do
        fill_in "Name", :with => "Here's a cool name"
        click_button "Create Collection"
      end
      it "should save it" do
        expect(page).to have_content("Here's a cool name")
        expect(Collection.first.name).to eq "Here's a cool name"
      end
    end
  end

end