require 'spec_helper'

describe 'About Us' do
  let(:user) {create(:user, :admin)}
  let(:setting) {create(:setting, :setting_name => "About")}
  before do
    user
    capybara_login(user) if user
    visit root_path
  end


  context "on the top navigation" do

    it "should have a link to the about us page" do
      expect(page).to have_link("About Us")
    end 

    context "and the link is clicked" do
      before do
        setting
        click_link "About Us"
      end

      it "should display the about us information" do
        expect(page).to have_content(setting.value)
      end
    end
  end

end