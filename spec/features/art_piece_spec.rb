require 'spec_helper'

describe "Art Piece Manipulation" do
  let(:user) {}
  let(:art) {build(:art_piece)}

  before do
    capybara_login(user) if user
    visit root_path
  end 

  context "when on the index page" do

    before do
      visit admin_art_pieces_path
    end

    context "and no art pieces are present" do
      #it "should display No Art Pieces Found!" do
      # 
      #end
    end

    context "and art pieces are present" do
      let(:user) {create(:user, :admin)}
      before do
        art
        art.title = "Example Title"
        art.save
        visit admin_art_pieces_path
      end
      it "should show the saved art piece" do
        expect(page).to have_content("Example Title")
      end

      it "should have links to edit and delete each art piece" do
        within "#piece-#{art.id}" do
          expect(page).to have_link "Edit"
          expect(page).to have_link "Delete"
        end
      end
      it "should take you to the edit page" do
        within "#piece-#{art.id}" do
          click_link "Edit"
        end
        expect(page).to have_content("Edit")
      end

      it "should delete the art piece" do
        within "#piece-#{art.id}" do
          click_link "Delete"
        end
        expect(page).to_not have_selector("#piece-#{art.id}")
      end
    end
  end

  context "When editing an art piece" do
    before do
      visit admin_art_pieces_path
    end

    context "and art pieces are present" do
      let(:user) {create(:user, :admin)}
      before do
        art
        art.title = "Example Title"
        art.save
        visit admin_art_pieces_path
        click_link "Edit"
      end
      it "should edit the art piece properly" do
        fill_in "Title", :with => "Example Title 2"
        click_button "Update Art piece"
        expect(page).to have_content("Example Title 2")
      end
    end
  end
end