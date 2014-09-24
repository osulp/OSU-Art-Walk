require 'spec_helper'

describe "help page" do
  let(:help) {create(:setting, :setting_name => "Help", :value => "this is helpful help page stuff")}
  before do
    visit root_path
  end
  it "should have a link to the help page in the navbar" do
    expect(page).to have_link("Help")
  end
  context "when there is help text entered" do
    before do 
      help
      visit root_path
      click_link "Help"
    end
    it "should display the help text" do
      expect(page).to have_content("Help Page")
      expect(page).to have_content(help.value)
    end
  end
  context "when there is not help text entered" do
    before do
      visit root_path
      click_link "Help"
    end
    it "should take you to the help page but not display content" do
      expect(page).to have_content("Help Page")
    end
  end
end
