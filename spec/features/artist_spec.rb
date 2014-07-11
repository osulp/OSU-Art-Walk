require 'spec_helper'

describe "Artist manipulation" do
  let(:user) {}
  let(:the_artist) {build(:artist)}

  before do
    capybara_login(user) if user
    visit root_path
  end 

  context "when on the index page" do
    let(:user) {create(:user, :admin)}

    before do
      visit admin_artists_path
    end

    context "and no artists are present in the database" do

      it "should display No Artists Are Currently In The Database" do
        expect(page).to have_content("No Artists Are Currently In The Database")
      end
    end

    context "and artists are present in the database" do
      before do
        the_artist
        the_artist.save
        visit admin_artists_path
      end
      it "should display the artist and all the information about them" do
        expect(page).to have_content(the_artist.name)
      end

      it "should have an edit and delete links for the specific artist" do
        within "#artist-#{the_artist.id}" do
          expect(page).to have_link "Edit"
          expect(page).to have_link "Delete"
        end
      end

      context "when clicking the edit button for a specific artist" do
        before do
          within "#artist-#{the_artist.id}" do
            click_link "Edit"
          end
        end

        it "should take you to the editing page to edit that artist" do
          expect(page).to have_content("Edit " + Artist.first.name)
        end
      end

      context "when clicking the add artist link" do

        it "should take you to the add new artist page" do
          click_link "Add Artist"
          expect(page).to have_content("Add New Artist")
        end
      end
    end
  end

  context "when on the edit page" do
    let(:user) {create(:user, :admin)}

    context "and artists are present" do
      before do
        the_artist
        the_artist.save
        visit admin_artists_path
      end

      it "should let you edit the artist and save it" do
        click_link "Edit"
        fill_in "Bio", :with => "This is the brand new bio!"
        click_button "Update Artist"
        expect(page).to have_content("This is the brand new bio!")
        expect(the_artist.reload.bio).to eq "This is the brand new bio!"
      end

      it "should let you delete a specific artist" do
        click_link "Delete"
        expect(page).to_not have_content(the_artist.name)
      end
    end
  end

  context "when on the add artist page" do
    let(:user) {create(:user, :admin)}
    before do
      visit new_admin_artist_path
    end

    it "should let you fill in the forms and save the artist" do
      fill_in "Bio", :with => "Here's a cool bio"
      click_button "Create Artist"
      expect(page).to have_content("Here's a cool bio")
      expect(Artist.first.bio).to eq "Here's a cool bio"
    end
  end

end