require 'spec_helper'

describe "Multi Photo" do
  
  let(:user) {create(:user, :admin)}

  before do
    user
    capybara_login(user) if user
    visit new_admin_art_piece_path
  end

  context "When adding a single photo" do
    before do
      #binding.pry
      fill_in "Title", :with => "Sample Title"
      within ("#picture") do
        attach_file("art_piece_art_piece_photos_attributes_0_photo", "app/assets/images/cats.jpg")
      end
      click_button "Create Art piece"
    end

    it "should save and display it" do
      expect(page).to have_css("img")
    end
  end

end