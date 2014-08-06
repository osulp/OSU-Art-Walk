require 'spec_helper' 

describe "showing artists with bios" do
  let(:art_piece) {create(:art_piece, :with_artist)}
  let(:art_piece2) {create(:art_piece)}
  let(:art_piece3) {create(:art_piece, :with_artists)}
  context "when viewing an art pieces' show page and the art piece has an artist" do
    before do
      art_piece
      visit catalog_path(:id => art_piece.document_id)
    end

    it "should display that art_piece" do
      expect(page).to have_content("Artist")
    end
  end
  context "when viewing an art pieces' show page and the art piece does not have an artist" do
    before do
      art_piece2
      visit catalog_path(:id => art_piece2.document_id)
    end

    it "should display that art_piece" do
      expect(page).to_not have_content("Artist")
    end
  end
  context "when viewing an art pieces' show page and the art piece has many artists" do
    before do
      art_piece3
      visit catalog_path(:id => art_piece3.document_id)
    end

    it "should display that art_piece" do
      expect(page).to have_content("Artist:", :count => 2)
    end
  end
end