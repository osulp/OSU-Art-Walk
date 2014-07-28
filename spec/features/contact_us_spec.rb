require 'spec_helper'

describe "Contact Us" do
  let(:setting) {create(:setting, :setting_name => "Email", :value => "contact@email.com") }
  
  before do
    setting
    visit root_path
  end

  it "should have a link to the contact us page" do
    expect(page).to have_content("Contact Us")
  end

  context "when viewing the contact us page" do
    before do
      click_link "Contact Us"
    end
    it "should display the contact info" do
      expect(page).to have_content("Contact Us")
      expect(page).to have_field("Message")
    end
  end
  context "when contacting us" do
    context "when there is not a user logged in" do
      context "when inputing an email" do
        before do
          visit contact_path
          fill_in "Email", :with => "test@email.com"
          fill_in "Message", :with => "test contact info"
          click_button "Submit"
        end
        it "should send an email" do
          expect(page).to have_content("Thank you for contacting us!")
          expect(ActionMailer::Base.deliveries.length).to eq 1
        end
      end
      context "when not inputing an email" do
        before do
          visit contact_path
          fill_in "Message", :with => "test message"
          click_button "Submit"
        end
        it "should cause an error to occur" do
          expect(page).to have_content("Please enter an email address and try again")
          expect(ActionMailer::Base.deliveries.length).to eq 0
        end
        it "should keep the entered message" do
          expect(page).to have_field("Message", :with => "test message")
        end
      end
    end
    context "when there is a user logged in" do
      let(:user) {create(:user)}
      before do
        capybara_login(user) if user
        visit contact_path
      end
      it "should display the user's email" do
        within "#main-container" do
          expect(page).to have_content(user.email)
        end
      end
      context "when submitting the form" do
        before do
          fill_in "Message", :with => "test contact info"
          click_button "Submit"
        end
        it "should send the email" do
          expect(page).to have_content("Thank you for contacting us!")
          expect(ActionMailer::Base.deliveries.length).to eq 1
        end
      end
    end
  end
end
