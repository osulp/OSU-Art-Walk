require "spec_helper"

describe "art piece location num" do
  context "when on the root path" do
    before do
      visit root_path
    end
    context "when adding an art piece" do
      let(:user) {create(:user, :admin)}
      before do
        capybara_login(user) if user
        visit root_path
        click_link "Admin Panel"
        click_link "Art Piece Information"
        click_link "Add Art Piece"
      end
      it "should have a position num field" do
        expect(page).to have_field("Position Number")
      end
    end
    context "when there are multiple art pieces in the building" do
      let(:art_piece1) {create(:art_piece, :with_artist, :building => building)}
      let(:art_piece2) {create(:art_piece, :with_artist, :building => building)}
      let(:art_piece3) {create(:art_piece, :with_artist, :building => building)}
      let(:building) {create(:building)}
      before do
        [art_piece3, art_piece1, art_piece2].each_with_index do |piece, index|
          piece.art_piece_building.position_num = index+1
          piece.save
        end
      end
      context "and when visiting the first art piece created", :js => true do
        before do
          visit root_path
          find(".leaflet-marker-icon").click
          click_link art_piece2.title
        end
        it "should be ordered by the position number" do
          expect(page).to have_content("2 of 3")
        end
        context "when visiting the next piece" do
          before do
            click_link "Next »"
          end
          it "should show the second art piece by position num" do
            expect(page).to have_content("3 of 3")
            expect(page).to have_content(art_piece1.title)
          end
        end
      end
    end
  end
end
