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
        context "and the images are being viewed on the show screen" do
          let(:art_piece_photos) do
            art_piece_2.art_piece_photos << create(:art_piece_photo, :with_photo)
            art_piece_2.art_piece_photos << create(:art_piece_photo, :with_photo)
            art_piece_2.save
          end
          before do
            art_piece_photos
            visit catalog_path(:id => art_piece_2.document_id)
          end
          it "should have the navigation arrows" do
            expect(page).to have_selector(".glyphicon-chevron-right")
          end
        end

        context "and there is only one image" do
          it "should not have navigation elements" do
            within(".ekko-lightbox") do
              expect(page).not_to have_selector(".glyphicon-chevron-right")
            end
          end
          context "on the show page" do
            before do
              visit catalog_path(:id => art_piece_2.document_id)
            end
            it "should not have the navigation elements" do
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
              within ".modal-body" do
                expect(page).to have_selector("img[src$='#{art_piece_2.art_piece_photos.last.photo}']")
              end
            end
          end
        end
      end
    end
  end

  context "when there is one art piece", :js => true do
    let(:art_piece) { create(:art_piece, :with_building) }

    context "and you visit its show page" do
      before do
        art_piece
        visit catalog_path(:id => art_piece.document_id)
      end
      context "and its private" do
        let(:art_piece) { create(:art_piece, :private => true) }

        it "should display the contact information" do
          expect(page).to have_content(art_piece.contact_info)
        end
      end
      context "and its not private" do
        let(:art_piece) { create(:art_piece, :private => false) }

        it "should not display the contact information" do
          expect(page).to_not have_content(art_piece.contact_info)
        end
      end
      it "should have tabs for a carousel and map" do
        expect(page).to have_link("Carousel")
        expect(page).to have_link("Map")
      end
      context "when the Map tab is clicked" do
        before do
          click_link "Map"
        end
        it "should show the map" do
          expect(page).to have_selector('.leaflet-map-pane')
        end
        it "should have one marker on it for the art_piece" do
          within ".leaflet-marker-pane" do
            expect(page).to have_selector(".leaflet-marker-icon", :count => 1)
          end
        end
        context "then the Carousel tab is clicked" do
          before do
            click_link "Carousel"
          end
          it "should switch back to carousel view" do
            expect(page).to have_selector(".carousel")
          end
        end
      end
    end
  end
end
