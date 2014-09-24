require 'spec_helper'

describe "searching" do
  let(:item) {create(:art_piece)}
  context "when there is a an item" do
    let(:search_string) {""}
    before do
      item
      visit root_path
      fill_in "Search...", :with => search_string
      click_button "Search"
    end
    context "and a blank string is searched" do
      before do
        click_link "List"
      end
      it "should find it" do
        expect(page).to have_selector(".document")
        expect(page).to have_content(item.title)
      end
      context "and the 10 per page button is clicked", :js => true do
        before do
          click_button "10 per page"
        end
        it "should open the dropdown" do
          expect(page).to have_selector(".open")
        end
      end
    end
    context "and a part is searched for" do
      before do
        click_link "List"
      end
      let(:item) {create(:art_piece, :title => "Warmest")}
      let(:search_string) {"warm"}
      it "should find it" do
        expect(page).to have_selector('.document')
      end
    end
    context "and its title is searched" do
      before do
        click_link "List"
      end
      let(:search_string) {item.title}
      it "should find it" do
        expect(page).to have_selector(".document")
        expect(page).to have_content(item.title)
      end
    end
    context "and displayed is false" do
      let(:item) {create(:art_piece, :displayed => false)}
      it "should not display the art piece" do
        expect(page).not_to have_selector('.document')
      end
    end
  end
end
