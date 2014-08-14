require 'spec_helper'

describe 'bookmark functionality', :js => true do
  
  let(:art_piece) {create(:art_piece, :with_building)}
  let(:art_piece2) {create(:art_piece, :with_building)}


  context 'when there are two art pieces in the database' do
    before do
      art_piece
      art_piece2
    end

    context "and one of the art pieces is bookmarked", :js => true do
      before do
        visit catalog_path(:id => art_piece.document_id)
        check "Bookmark"
        expect(page).to have_content("In Bookmarks")
      end

      context "and the bookmark path is visited" do
        before do
          visit bookmarks_path
        end

        it "should only show one art piece on map" do
          expect(page).to have_selector(".leaflet-marker-icon", :count => 1)
        end
      end
    end
  end
end