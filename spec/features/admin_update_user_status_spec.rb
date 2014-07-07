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
      it "should show an admin status for the current user" do
        within "#userstatus-#{user.id} .status" do
          expect(page).to have_content("Admin")
        end
      end
      context "and there are two users" do
        let(:user_2) {create(:user)}
        it "should show a user status for the current user" do
          within "#userstatus-#{user_2.id} .status" do
            expect(page).to have_content("User")
          end
        end
      end
    end
  end
end