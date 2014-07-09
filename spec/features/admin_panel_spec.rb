require 'spec_helper'

describe "admin panel" do
  let(:user) {}
  before do
    capybara_login(user) if user
    visit root_path
  end 
  context "when not logged in" do
    it "should not have an admin panel link" do
      expect(page).not_to have_link("Admin Panel")
    end
    it "should not let you access admin panel utils" do
      visit admin_index_path
      expect(page).to have_content("Only admin can access")
    end
  end
  context "when logged in as a non-admin" do
    let(:user) {create(:user)}
    it "should not have an admin panel link" do
      expect(page).not_to have_link("Admin Panel")
    end
  end
  context "when logged in as an admin" do
    let(:user) {create(:user, :admin)}
    it "should have an admin panel link" do
      expect(page).to have_link("Admin Panel")
      click_link "Admin Panel"
      expect(page).to have_content("Administration Dashboard")
    end

    context "when on the Admin panel page" do
      it "should have the administration dashboard on it" do
        visit admin_index_path
        expect(page).to have_selector('#dashboard')
      end
      context "should have a clickable Edit Information link on it" do
        before do
          visit admin_index_path
          expect(page).to have_link("Art Piece Information")
        end

        it "should link you to the list of editable information" do
          click_link "Art Piece Information"
          expect(page).to have_content("Edit Art Piece Information")
        end
      end
    end
  end
end