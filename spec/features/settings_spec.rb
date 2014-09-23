require "spec_helper"

describe "settings" do
  let(:user) {}
  let(:setting) {create(:setting)}
  let(:setting_2) {create(:setting, :setting_name => "Copyright", :value => "Test Copyright")}

  before do
    capybara_login(user) if user
    setting_2
    visit root_path
  end
  
  context "when on the admin page" do
    let(:user) {create(:user, :admin)}
    let(:setup) {}
    context "when copyright information has been entered" do
      it "should have it on the bottom of the page" do
        within ".footer" do
          expect(page).to have_content("Test Copyright")
        end
      end
    end
    before do
      setup
      visit admin_index_path
      click_link "Settings"
    end
    it "should have an empty footer" do
      within ".footer" do
        expect(page).to have_content("")
      end
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
            }, "Copyright" => {}, "Title" => ""
          })
        end
        before do
          expect(page).to have_selector(".setting", :count => Setting.default_settings.length)
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
          expect(page).to have_content("Help")
        end
      end
    end
  end
  context "when on the root page" do
    let(:setting2) {create(:setting, :setting_name => "Home", :value => "Test Value")}
    before do
      setting2
      visit root_path
    end
    context "when home information has been entered" do
      it "should have it on the home page" do
        expect(page).to have_content("Test Value")
      end
    end
    context "when title information has been entered" do
      let(:setting2) {create(:setting, :setting_name => "Title", :value => "Test Title")}
      it "should have it on the home page" do
        expect(page).to have_title "Test Title"
      end
    end
    context "when no title information has been entered" do
      it "should display the default title" do
        expect(page).to have_title I18n.t('blacklight.application_name')
      end
    end
  end
end
