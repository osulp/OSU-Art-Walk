require "spec_helper"

describe "hidden items" do
  let(:user) {}
  let(:item) {create(:art_piece, :displayed => false)}

  before do
    capybara_login(user) if user
    visit root_path
  end

  context "when on the index page" do
    let(:user) {create(:user)}
    let(:item) {create(:art_piece, :with_building, :displayed => true )}
    before do
      item
      visit root_path
      click_button "Search"
    end
    it "should not have the Displayed facet" do
      expect(page).not_to have_link("Displayed")
    end
    it "should have other facets" do
      expect(page).to have_link("Building")
    end
  end
  context "when on the index page as an admin" do
    let(:user) {create(:user, :admin)}
    before do
      visit root_path
    end
    context "when searching for all art pieces as admin" do
      before do
        item
        click_button "Search"
      end
      it "should display the item where 'displayed' is false" do
        expect(page).to have_selector(".document")
      end
      it "should display the 'Displayed' facet" do
        expect(page).to have_link("Displayed")
      end
    end
  end
end
