require 'spec_helper'

describe "Multi Photo" do
  
  let(:user) {create(:user, :admin)}

  before do
    user
    capybara_login(user) if user
    visit new_admin_art_piece_path
  end

  context "When adding a single photo" do
    before do
      fill_in "Title", :with => "Sample Title"
      within ("#picture") do
        attach_file("art_piece_art_piece_photos_attributes_0_photo", "spec/fixtures/cats.jpg")
      end
    end

    it "should have a field for caption" do
      expect(page).to have_content("Photo credit")
    end
    
    context "When creating the art piece with the photo" do
      before do
        fill_in "Photo credit", :with => "I took this beautiful picture"
        click_button "Create Art piece"
      end
      it "should save and display it" do
        expect(page).to have_css("img")
      end
      it "should display the photo credit for the photo" do
        expect(page).to have_content("I took this beautiful picture")
      end
    end
  end

  context "When adding multiple photos", :js => true do
    before do
      fill_in "Title", :with => "Sample Title"
      click_link "Add Another Photo"
      photos = all("*[id^=art_piece_art_piece_photos]")
      photos.each do |photo_wrapper|
        unless photo_wrapper[:id].include? "photo_credit"
          attach_file photo_wrapper[:id], Rails.root.join("spec", "fixtures", "cats.jpg")
        end
      end
      click_button "Create Art piece"
      expect(page).to have_content("Successfully created art piece")
      @piece = ArtPiece.first
    end

    it "should save and display them" do
      click_link @piece.title
      within("#piece-#{@piece.id}") do
        expect(page).to have_selector('img', :count => 2)
      end
    end

    context "when deleting the field for adding pictures", :js => true do
      before do
        click_link "Edit"
        photos = all("*[id^=picture]")
        photos.each do |photo_wrapper|
          within photo_wrapper do
            click_link "remove"
          end
        end
        click_button "Update Art piece"
      end
      it "Should delete the field" do
        within ".panel-group" do
          expect(page).to_not have_selector("img")
        end
        expect(ArtPiecePhoto.all.count).to eq 0
      end
    end
  end

end
