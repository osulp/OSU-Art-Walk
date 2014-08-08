require 'spec_helper' 

describe "showing artists with bios" do
  let(:art_piece) {create(:art_piece, :with_artist)}
  context "when viewing an art pieces' show page" do
    before do
      visit catalog_path(:id => art_piece.document_id)
    end
    context "and the art piece has an artist" do
      it "should display that art piece's artist" do
        expect(page).to have_content("Artist")
      end
    end
    context "and the art piece does not have an artist" do
      let(:art_piece) {create(:art_piece)}
      it "should not display that art_piece's artist" do
        expect(page).to_not have_content("Artist")
      end
    end
    context "and the art piece has many artists" do
      let(:art_piece) {create(:art_piece, :with_artists)}
      it "should display that art piece's artists" do
        expect(page).to have_content("Artist:", :count => 2)
      end
    end
  end
end