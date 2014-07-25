require 'spec_helper'

describe "catalog show" do
  context "when there are two art pieces" do
    let(:art_piece) { create(:art_piece) }
    let(:art_piece_2) { create(:art_piece) }
    before do
      art_piece
      art_piece_2
    end
    context "and the first is visited" do
      before do
        visit catalog_path(:id => art_piece.document_id) 
      end
      it "should show the correct title" do
        expect(page).to have_content(art_piece.title)
      end
      # The javascript is erroring and nobody knows why.
      # TODO: Fix this.
      context "and the first picture is clicked on", :js => true do
        let(:user) {create(:user, :admin => true) }
        before do
          capybara_login(user) if user
          visit admin_index_path
          click_link "Art Piece Information"
          click_link "Add Art Piece"
          fill_in "Title", :with => "AAAaAAAA"
          within("#picture") do
            attach_file("art_piece_art_piece_photos_attributes_0_photo", "spec/fixtures/cats.jpg")
          end
          click_button "Create Art piece"
          visit catalog_path(:id => ArtPiece.last.document_id)
          binding.pry
          find("#photo-0 img").click
        end
        xit "should open a lighbox view" do
          within ".modal-body" do
            expect(page).to have_content(art_piece.art_piece_photos.first)
          end
        end
        xit "should have navigation elements" do
          within ".ekko-lightbox-nav-overlay" do
            expect(page).to have_selector(".glyphicon-chevron-right")
          end
        end
        context "when viewing next photo" do
          before do
            click_link .glyphicon-chevron-right
          end
          xit "should display the second image" do
            expect(page).to have_content(art_piece.art_piece_photos.last)
          end
        end
      end
    end
  end
end
