require 'spec_helper'

describe "admin update user status" do
  let(:user) {create(:user, :admin)}
  let(:user_2) {}

  before do
    user_2
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
      it "should have a status of Admin" do
        within("#userstatus-#{user.id} .status") do
          expect(page).to have_content("Admin")
        end
      end
      context "when there's another user" do
        let(:user_2) {create(:user)}
        it "should have a status of User" do
          within("#userstatus-#{user_2.id} .status") do
            expect(page).to have_content("User")
          end
        end
      end
    end
  end
end