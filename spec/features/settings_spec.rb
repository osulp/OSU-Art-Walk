require "spec_helper"

describe "settings" do
  let(:user) {}
  let(:setting) {create(:setting)}

  before do
    capybara_login(user) if user
    visit root_path
  end
  
  context "when on the admin page" do
    let(:user) {create(:user, :admin)}
    let(:setup) {}
    before do
      setup
      visit admin_index_path
      click_link "Settings"
    end
    it "should go to the settings page" do
      expect(page).to have_content("Settings Page")
    end
    context "when on the setting index page" do
      let(:user) {create(:user, :admin)}
      it "should display the settings page" do
        expect(page).to have_content("Settings Page")
      end
      context "when there are settings entered" do
        before do
          setting
          visit admin_settings_path
        end
        it "should display the settings information" do
          expect(page).to have_content("#{setting.setting_name}")
        end
        context "when editing the setting" do
          it "should display the setting information" do
            expect(page).to have_content(setting.setting_name)
            expect(page).to have_field("Value", :with => setting.value)
          end
          context "when updating the setting information" do
            before do
              within("#setting-#{setting.id}") do
                fill_in "Value", :with => "Copyright information is please do not steal."
                click_button "Update Setting"
              end
            end
            it "should update and display the settings" do
              expect(page).to have_content("Copyright information is please do not steal.")
              expect(page).to have_content("Copyright")
            end
          end
        end
      end
      context "when there are configured field types" do
        let(:setup) do
          Setting.stub(:default_settings).and_return({
            "email" => {
              "tag_attributes" => {
                "type" => "email"
              }
            }
          })
        end
        before do
          expect(page).to have_selector(".setting", :count => 1)
        end
        it "should use it" do
          expect(page).to have_selector("input[type=email]")
        end
      end
      context "when there are no settings configured" do
        it "should display three default settings" do
          expect(page).to have_content("Email")
          expect(page).to have_content("Copyright")
          expect(page).to have_content("About")
        end
      end
    end
  end
end
