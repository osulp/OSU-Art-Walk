require 'spec_helper'

describe Setting do
  it {should validate_presence_of(:setting_name) }
  it {should validate_uniqueness_of(:setting_name) }

  describe "#create_defaults" do

    context "when there are no default setting names present" do
      let(:user) {create(:user, :admin)}

      before do
        user
        capybara_login_two(user) if user
        Setting.create_defaults
        visit "/admin/settings"
      end
      it "should create the defaults with their setting_names" do
        expect(page).to have_content("Email")
        expect(page).to have_content("Copyright")
        expect(page).to have_content("About")
      end
    end
  end
end
