require 'spec_helper'

describe "changing user status" do
  let(:user){create(:user, :admin)}
  before do
    capybara_login(user) if user
    visit admin_users_path
  end

  it "should have users displayed with their email and administrative status" do
    expect(page).to have_content("User Email:")
  end

  context "when the edit link is clicked, it brings you to the edit page" do
    before do
      user1 = User.first
     
      within "#userstatus-#{user1.id}" do
        click_link "Edit"
      end
    end

    it "should bring you to the edit page where you can edit the admin status and save" do
      expect(page).to have_content("Edit Users Administrative Status")
    end

    context "when the box is checked or unchecked" do

      context "when an admin tries to update their own status" do
        it "should display an error message" do
          uncheck "Checked means has admin status"
          click_button "Update User"
          expect(page).to have_content("You can't change your own status")
        end
      end
      context "when an admin tries to update someone elses status" do
        before do
          create(:user, :admin)
          visit admin_users_path
          within "#userstatus-#{User.last.id}" do
            click_link "Edit"
          end
        end

        it "should let you click update user and update the users admin status" do
          uncheck "Checked means has admin status"
          click_button "Update User"
          expect(User.last.admin).to eq false
        end
      end
    end
  end
end