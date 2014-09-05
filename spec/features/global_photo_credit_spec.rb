require 'spec_helper'

describe "global photo credit" do
  let(:user) {create(:user, :admin)}
  context "when creating a new art piece" do
    before do
      capybara_login(user) if user
      visit new_admin_art_piece_path
    end
    it "should have a field for global credit" do
      expect(page).to have_field("Global photo credit")
    end
    context "when creating the art piece with global credit" do
      before do
        fill_in " Title", :with => "test title"
        fill_in "Global photo credit", :with => "credit for all the photos on the art piece"
        within ("#picture") do
          attach_file("art_piece_art_piece_photos_attributes_0_photo", "spec/fixtures/cats.jpg")
        end
        click_button "Create Art piece"
      end
      it "should save and display the art piece" do
        expect(page).to have_content("test title")
      end
      context "when viewing the created art piece" do
        before do
          visit catalog_path(:id => ArtPiece.first.document_id)
        end
        it "should display the global caption in the carousel" do
          within(".carousel") do
            expect(page).to have_content("credit for all the photos on the art piece")
          end
        end
      end
    end
    context "when creating an art piece with global and individual credit" do
      before do
        fill_in " Title", :with => "test title"
        fill_in "Global photo credit", :with => "credit for photo"
        within ("#picture") do
          attach_file("art_piece_art_piece_photos_attributes_0_photo", "spec/fixtures/cats.jpg")
        end
        fill_in "Photo credit", :with => "individual photo credit"
        click_button "Create Art piece"
        visit catalog_path(:id => ArtPiece.first.document_id)
      end
      it "should display only the individual photo credit on the carousel" do
        within(".carousel") do
          expect(page).to have_content("individual photo credit")
        end
      end
    end
  end
end
