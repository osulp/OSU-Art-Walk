require 'spec_helper'

describe "more button" do
  before do
    visit root_path
  end

  context "when there are fewer than 10 buildings with art pieces" do
    before do
      create(:art_piece, :with_building)
      visit root_path
    end
    it "should not have a more link" do
      expect(page).to_not have_link("more »")
    end
  end
  context "when there are more than 10 buildings with art pieces" do
    before do
      12.times do
        create(:art_piece, :with_building)
      end
      visit root_path
    end
    it "should have a more link" do
      expect(page).to have_link("more »")
    end
  end
end
