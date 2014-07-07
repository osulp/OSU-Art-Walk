require 'spec_helper'

describe "admin update user status" do
  let(:user) {create(:user, :admin)}

  before do
    capybara_login(user) if user
    visit admin_index_path
  end

  context "when trying to update a user" do

    it "should have a link called update user status" do
      expect(page).to have_link("Update User Status")
    end

    context "when the update user status link is clicked" do

      before do
        click_link "Update User Status"
      end

      it "should take you to the index for the admin_users_controller" do
        expect(page).to have_content("List of Users")
      end
    end
  end
end