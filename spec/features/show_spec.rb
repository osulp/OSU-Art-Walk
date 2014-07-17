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
    end
  end
end
