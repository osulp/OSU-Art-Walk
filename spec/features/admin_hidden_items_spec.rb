require "spec_helper"

describe "hidden items" do
  let(:user) {}
  let(:item) {create(:art_piece, :displayed => false)}

  before do
    capybara_login(user) if user
    visit root_path
  end

  context "when on the index page" do
    let(:user) {create(:user, :admin)}
    before do
      visit root_path
    end
    it "should be logged in as an admin" do
      expect(page).to have_link("Admin Panel")
    end
    context "when searching for all art pieces" do
      before do
        item
        click_button "Search"
      end
      it "should display the item where 'displayed' is false" do
        expect(page).to have_selector(".document")
      end
    end
  end
end
