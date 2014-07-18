require 'spec_helper'

describe 'About Us' do
  let(:user) {create(:user, :admin)}
  before do
    user
    capybara_login(user) if user
    visit root_path
  end


  context "on the top navigation" do

    it "should have a link to the about us page" do
      expect(page).to have_link("About Us")
    end 

    context "should have link to about us" do
      before do
        click_link "About Us"
      end
      it "and route to about us page" do
        expect(page).to have_content("About Us!")
      end
    end
  end

end