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
        let(:art_piece_photos) do
          art_piece_2.art_piece_photos << create(:art_piece_photo, :with_photo)
          art_piece_2.save
        end
        before do
          art_piece_photos
          capybara_login(user) if user
          visit catalog_path(:id => art_piece_2.document_id)
          find("#photo-0 img").click
        end
        it "should open a lighbox view" do
          within ".modal-body" do
            expect(page).to have_selector("img[src$='#{art_piece_2.art_piece_photos.first.photo}']")
          end
        end
        context "and there is only one image" do
          it "should not have navigation elements" do
            within(".ekko-lightbox") do
              expect(page).not_to have_selector(".glyphicon-chevron-right")
            end
          end
        end
        context "when there are two images" do
          context "when viewing next photo" do
            let(:art_piece_photos) do
              2.times { art_piece_2.art_piece_photos << create(:art_piece_photo, :with_photo) }
              art_piece_2.save
            end
            before do
              within ".modal-body" do
                find(".glyphicon-chevron-right").trigger(:click)
              end
            end
            it "should display the second image" do
              sithin ".modal-body" do
                expect(page).to have_selector("img[src$='#{art_piece_2.art_piece_photos.last.photo}']")
              end
            end
          end
        end
      end
    end
  end
end
